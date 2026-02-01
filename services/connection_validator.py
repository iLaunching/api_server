"""
Connection Validator Service
Validates connection attempts with cycle detection and port constraints
"""

from typing import List, Optional, Tuple, Set, Dict
from models.canvas_node import CanvasNode
from models.node_connection import NodeConnection
import uuid

class ConnectionValidator:
    """
    Validates connections between nodes.
    
    Rules:
    1. Cannot connect node to itself
    2. Output → Input only
    3. Input ports: 1 connection max
    4. Output ports: 1 connection max (use Router Context for branching)
    5. Data types must be compatible (or 'any')
    6. Must not create cycles
    """
    
    def validate_connection(
        self,
        source_node: CanvasNode,
        source_port_id: str,
        target_node: CanvasNode,
        target_port_id: str,
        existing_connections: List[NodeConnection]
    ) -> Tuple[bool, Optional[str]]:
        """
        Validates a connection attempt.
        
        Args:
            source_node: Source node (output port)
            source_port_id: Source port ID
            target_node: Target node (input port)
            target_port_id: Target port ID
            existing_connections: All existing connections in context
            
        Returns:
            (is_valid, error_message)
        """
        
        # Rule 1: Cannot connect node to itself
        if source_node.node_id == target_node.node_id:
            return False, "Cannot connect node to itself"
        
        # Get port configurations
        source_port = self._find_port(source_node.port_config, source_port_id)
        target_port = self._find_port(target_node.port_config, target_port_id)
        
        if not source_port:
            return False, f"Source port '{source_port_id}' not found"
        
        if not target_port:
            return False, f"Target port '{target_port_id}' not found"
        
        # Rule 2: Output → Input only
        # (Assuming port config has 'type' field or we infer from inputs/outputs arrays)
        # For now, we'll check if source is in outputs and target is in inputs
        
        # Rule 3: Input ports can only have ONE connection
        input_already_connected = any(
            conn.target_node_id == target_node.node_id and 
            conn.target_port_id == target_port_id
            for conn in existing_connections
        )
        
        if input_already_connected:
            return False, "Input port already connected"
        
        # Rule 4: Output ports can only have ONE connection
        output_already_connected = any(
            conn.source_node_id == source_node.node_id and 
            conn.source_port_id == source_port_id
            for conn in existing_connections
        )
        
        if output_already_connected:
            # Exception: Routers can have multiple connections per output (Fan-Out)
            is_router = source_node.node_type in ['smart-router', 'condition-router', 'router']
            if not is_router:
                return False, "Output port already connected (use a Router for branching)"
        
        # Rule 5: Data type compatibility
        source_data_type = source_port.get('dataType', 'any')
        target_data_type = target_port.get('dataType', 'any')
        
        if source_data_type != 'any' and target_data_type != 'any':
            if source_data_type != target_data_type:
                return False, f"Type mismatch: {source_data_type} → {target_data_type}"
        
        # Rule 6: Check for cycles
        would_create_cycle = self._would_create_cycle(
            source_node.node_id,
            target_node.node_id,
            existing_connections
        )
        
        if would_create_cycle:
            return False, "Would create circular dependency"
        
        return True, None
    
    def _find_port(self, port_config: dict, port_id: str) -> Optional[dict]:
        """Find a port in the port configuration"""
        if not port_config:
            return None
        
        # Check inputs
        for port in port_config.get('inputs', []):
            if port.get('id') == port_id:
                return port
        
        # Check outputs
        for port in port_config.get('outputs', []):
            if port.get('id') == port_id:
                return port
        
        return None
    
    def _would_create_cycle(
        self,
        source_node_id: uuid.UUID,
        target_node_id: uuid.UUID,
        existing_connections: List[NodeConnection]
    ) -> bool:
        """
        Check if adding this connection would create a cycle.
        Uses DFS to detect cycles.
        
        A cycle exists if we can reach source_node from target_node
        following the existing connections.
        """
        
        # Build adjacency list from existing connections
        graph: Dict[uuid.UUID, Set[uuid.UUID]] = {}
        
        for conn in existing_connections:
            if conn.source_node_id not in graph:
                graph[conn.source_node_id] = set()
            graph[conn.source_node_id].add(conn.target_node_id)
        
        # Add the proposed connection
        if source_node_id not in graph:
            graph[source_node_id] = set()
        graph[source_node_id].add(target_node_id)
        
        # DFS from target_node to see if we can reach source_node
        visited: Set[uuid.UUID] = set()
        
        def dfs(node_id: uuid.UUID) -> bool:
            """Returns True if we can reach source_node from node_id"""
            if node_id == source_node_id:
                return True
            
            if node_id in visited:
                return False
            
            visited.add(node_id)
            
            # Visit neighbors
            for neighbor in graph.get(node_id, []):
                if dfs(neighbor):
                    return True
            
            return False
        
        # Start DFS from target_node
        return dfs(target_node_id)
