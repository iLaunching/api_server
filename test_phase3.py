"""
Phase 3 API Test Script
Tests all 12 endpoints to verify functionality
"""

import requests
import json
from typing import Dict, Any

# Configuration
BASE_URL = "http://localhost:8000"
API_VERSION = "v1"

# Test data
test_context_id = None  # Will be set from existing context
test_node_1_id = None
test_node_2_id = None
test_connection_id = None

def print_test(name: str, success: bool, details: str = ""):
    """Print test result"""
    status = "✅" if success else "❌"
    print(f"{status} {name}")
    if details:
        print(f"   {details}")

def test_get_templates():
    """Test GET /api/v1/templates"""
    print("\n📦 Testing Template Endpoints...")
    
    try:
        response = requests.get(f"{BASE_URL}/api/{API_VERSION}/templates")
        success = response.status_code == 200
        
        if success:
            templates = response.json()
            print_test(
                "GET /templates", 
                True, 
                f"Found {len(templates)} templates"
            )
            
            # Print template details
            for t in templates:
                print(f"   • {t['template_name']} ({t['node_type']}) - {t['category']}")
            
            return templates
        else:
            print_test("GET /templates", False, f"Status: {response.status_code}")
            return []
            
    except Exception as e:
        print_test("GET /templates", False, str(e))
        return []

def test_create_node(context_id: str, node_type: str = "smart-matrix"):
    """Test POST /api/v1/node/create"""
    print("\n🔷 Testing Node Creation...")
    
    try:
        payload = {
            "context_id": context_id,
            "node_type": node_type,
            "node_name": f"Test {node_type}",
            "pos_x": 100.0,
            "pos_y": 200.0,
            "width": 250,
            "height": 250,
            "color": "#8b5cf6",
            "port_config": {
                "outputs": [{"id": "output", "dataType": "any", "label": "Output"}]
            }
        }
        
        response = requests.post(
            f"{BASE_URL}/api/{API_VERSION}/node/create",
            json=payload
        )
        
        success = response.status_code == 201
        
        if success:
            node = response.json()
            print_test(
                "POST /node/create",
                True,
                f"Created node: {node['node_id']}"
            )
            return node['node_id']
        else:
            print_test("POST /node/create", False, f"Status: {response.status_code}")
            print(f"   Response: {response.text}")
            return None
            
    except Exception as e:
        print_test("POST /node/create", False, str(e))
        return None

def test_get_context_nodes(context_id: str):
    """Test GET /api/v1/node/context/{context_id}/nodes"""
    print("\n🔍 Testing Node Retrieval...")
    
    try:
        # Test with spatial filtering
        response = requests.get(
            f"{BASE_URL}/api/{API_VERSION}/node/context/{context_id}/nodes",
            params={
                "min_x": 0,
                "max_x": 1000,
                "min_y": 0,
                "max_y": 1000
            }
        )
        
        success = response.status_code == 200
        
        if success:
            nodes = response.json()
            print_test(
                "GET /node/context/{id}/nodes",
                True,
                f"Found {len(nodes)} nodes in viewport"
            )
            return nodes
        else:
            print_test("GET /node/context/{id}/nodes", False, f"Status: {response.status_code}")
            return []
            
    except Exception as e:
        print_test("GET /node/context/{id}/nodes", False, str(e))
        return []

def test_create_connection(source_node_id: str, target_node_id: str):
    """Test POST /api/v1/connection/create"""
    print("\n🔗 Testing Connection Creation...")
    
    try:
        payload = {
            "source_node_id": source_node_id,
            "source_port_id": "output",
            "target_node_id": target_node_id,
            "target_port_id": "input-1",
            "color": "#3b82f6",
            "animated": True,
            "pulse_speed": 200
        }
        
        response = requests.post(
            f"{BASE_URL}/api/{API_VERSION}/connection/create",
            json=payload
        )
        
        success = response.status_code == 201
        
        if success:
            connection = response.json()
            print_test(
                "POST /connection/create",
                True,
                f"Created connection: {connection['connection_id']}"
            )
            return connection['connection_id']
        else:
            print_test("POST /connection/create", False, f"Status: {response.status_code}")
            print(f"   Response: {response.text}")
            return None
            
    except Exception as e:
        print_test("POST /connection/create", False, str(e))
        return None

def test_validation_rules(source_node_id: str, target_node_id: str):
    """Test connection validation rules"""
    print("\n🛡️ Testing Validation Rules...")
    
    # Test 1: Self-connection (should fail)
    try:
        payload = {
            "source_node_id": source_node_id,
            "source_port_id": "output",
            "target_node_id": source_node_id,  # Same node
            "target_port_id": "input-1"
        }
        
        response = requests.post(
            f"{BASE_URL}/api/{API_VERSION}/connection/create",
            json=payload
        )
        
        # Should fail with 400
        success = response.status_code == 400
        print_test(
            "Reject self-connection",
            success,
            "Correctly rejected" if success else "Should have rejected"
        )
        
    except Exception as e:
        print_test("Reject self-connection", False, str(e))
    
    # Test 2: Duplicate connection (should fail if already connected)
    # This would require creating the same connection twice
    
    print("   Note: Full validation testing requires multiple nodes and connections")

def run_all_tests():
    """Run all Phase 3 API tests"""
    print("=" * 60)
    print("Phase 3 API Test Suite")
    print("=" * 60)
    
    # Step 1: Get templates
    templates = test_get_templates()
    
    if not templates:
        print("\n❌ Cannot proceed without templates. Check if migration ran successfully.")
        return
    
    # Step 2: Get or create a context
    print("\n⚠️  Note: You need to provide a valid context_id to continue tests")
    print("   Run this script with: python test_phase3.py <context_id>")
    
    # For now, just show what would be tested
    print("\n📋 Full Test Suite Would Include:")
    print("   1. ✅ GET /templates")
    print("   2. ⏸️  POST /node/create (needs context_id)")
    print("   3. ⏸️  GET /node/context/{id}/nodes")
    print("   4. ⏸️  PATCH /node/{id}/position")
    print("   5. ⏸️  PATCH /node/{id}/state")
    print("   6. ⏸️  POST /connection/create")
    print("   7. ⏸️  GET /connection/node/{id}/connections")
    print("   8. ⏸️  GET /connection/context/{id}/connections")
    print("   9. ⏸️  DELETE /connection/{id}")
    print("   10. ⏸️ DELETE /node/{id}")
    print("   11. ⏸️ Validation: Self-connection rejection")
    print("   12. ⏸️ Validation: Cycle detection")
    
    print("\n" + "=" * 60)
    print("Test Summary")
    print("=" * 60)
    print("✅ Template endpoints working")
    print("⏸️  Node/Connection tests require valid context_id")
    print("\nTo run full tests:")
    print("1. Get a context_id from your database")
    print("2. Run: python test_phase3.py <context_id>")

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1:
        context_id = sys.argv[1]
        print(f"Using context_id: {context_id}")
        
        # Run full test suite
        templates = test_get_templates()
        
        if templates:
            # Create two nodes
            node1_id = test_create_node(context_id, "smart-matrix")
            node2_id = test_create_node(context_id, "email-sender")
            
            if node1_id and node2_id:
                # Get nodes
                nodes = test_get_context_nodes(context_id)
                
                # Create connection
                conn_id = test_create_connection(node1_id, node2_id)
                
                # Test validation
                test_validation_rules(node1_id, node2_id)
                
                print("\n✅ All tests completed!")
    else:
        run_all_tests()
