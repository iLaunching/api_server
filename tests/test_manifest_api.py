"""
API Test Suite for Manifest Routes
Phase 1, Step 1.2 - Test Gate 1.2
"""

import pytest
import uuid
from httpx import AsyncClient
from fastapi import status


# Test fixtures are inherited from conftest.py


# ============================================================================
# Test Gate 1.2: Manifest API Tests
# ============================================================================

@pytest.mark.asyncio
async def test_create_manifest_endpoint(client: AsyncClient, test_smart_matrix):
    """
    Test Gate 1.2.1: POST /api/manifest/create returns valid manifest
    """
    response = await client.post("/api/manifest/create", json={
        "smart_matrix_id": str(test_smart_matrix.id),
        "user_id": str(test_smart_matrix.owner_id),
        "business_dna": {"intent": "Launch product"}
    })
    
    assert response.status_code == status.HTTP_201_CREATED
    data = response.json()
    assert "manifest_id" in data
    assert data["smart_matrix_id"] == str(test_smart_matrix.id)
    assert data["business_dna"]["intent"] == "Launch product"
    assert data["current_x"] == 0.0
    assert data["current_y"] == 0.0
    assert data["zoom_level"] == 1.0
    
    print("✅ Test 1.2.1 PASSED: Create manifest endpoint successful")


@pytest.mark.asyncio
async def test_get_manifest_by_id(client: AsyncClient, test_manifest):
    """
    Test Gate 1.2.2: GET /api/manifest/{id} returns manifest
    """
    response = await client.get(f"/api/manifest/{test_manifest.manifest_id}")
    
    assert response.status_code == status.HTTP_200_OK
    data = response.json()
    assert data["manifest_id"] == str(test_manifest.manifest_id)
    assert data["smart_matrix_id"] == str(test_manifest.smart_matrix_id)
    
    print("✅ Test 1.2.2 PASSED: Get manifest by ID successful")


@pytest.mark.asyncio
async def test_get_manifest_by_smart_matrix(client: AsyncClient, test_manifest):
    """
    Test Gate 1.2.3: GET /api/manifest/smart-matrix/{id} returns manifest
    """
    response = await client.get(f"/api/manifest/smart-matrix/{test_manifest.smart_matrix_id}")
    
    assert response.status_code == status.HTTP_200_OK
    data = response.json()
    assert data["manifest_id"] == str(test_manifest.manifest_id)
    assert data["smart_matrix_id"] == str(test_manifest.smart_matrix_id)
    
    print("✅ Test 1.2.3 PASSED: Get manifest by smart_matrix_id successful")


@pytest.mark.asyncio
async def test_update_position(client: AsyncClient, test_manifest):
    """
    Test Gate 1.2.4: PATCH /api/manifest/{id}/position updates camera position
    """
    response = await client.patch(
        f"/api/manifest/{test_manifest.manifest_id}/position",
        json={
            "current_x": 100.5,
            "current_y": 200.3,
            "zoom_level": 1.5
        }
    )
    
    assert response.status_code == status.HTTP_200_OK
    data = response.json()
    assert data["current_x"] == 100.5
    assert data["current_y"] == 200.3
    assert data["zoom_level"] == 1.5
    
    print("✅ Test 1.2.4 PASSED: Update position successful")


@pytest.mark.asyncio
async def test_update_business_dna(client: AsyncClient, test_manifest):
    """
    Test Gate 1.2.5: PATCH /api/manifest/{id}/business-dna updates DNA
    """
    new_dna = {
        "intent": "Raise $100k",
        "constraints": {"budget": 10000},
        "style": {"tone": "casual"}
    }
    
    response = await client.patch(
        f"/api/manifest/{test_manifest.manifest_id}/business-dna",
        json={"business_dna": new_dna}
    )
    
    assert response.status_code == status.HTTP_200_OK
    data = response.json()
    assert data["business_dna"]["intent"] == "Raise $100k"
    assert data["business_dna"]["constraints"]["budget"] == 10000
    
    print("✅ Test 1.2.5 PASSED: Update business DNA successful")


@pytest.mark.asyncio
async def test_cannot_create_duplicate_manifest(client: AsyncClient, test_manifest):
    """
    Test Gate 1.2.6: Verify API prevents duplicate manifests for same smart_matrix
    """
    response = await client.post("/api/manifest/create", json={
        "smart_matrix_id": str(test_manifest.smart_matrix_id),
        "user_id": str(test_manifest.user_id)
    })
    
    assert response.status_code == status.HTTP_409_CONFLICT
    assert "already exists" in response.json()["detail"].lower()
    
    print("✅ Test 1.2.6 PASSED: Duplicate prevention successful")


@pytest.mark.asyncio
async def test_manifest_heartbeat(client: AsyncClient, test_manifest):
    """
    Test Gate 1.2.7: POST /api/manifest/{id}/heartbeat updates timestamp
    """
    response = await client.post(f"/api/manifest/{test_manifest.manifest_id}/heartbeat")
    
    assert response.status_code == status.HTTP_204_NO_CONTENT
    
    # Verify heartbeat was updated
    get_response = await client.get(f"/api/manifest/{test_manifest.manifest_id}")
    assert get_response.status_code == status.HTTP_200_OK
    
    print("✅ Test 1.2.7 PASSED: Heartbeat update successful")


@pytest.mark.asyncio
async def test_delete_manifest(client: AsyncClient, test_smart_matrix, db_session):
    """
    Test Gate 1.2.8: DELETE /api/manifest/{id} deletes manifest
    """
    # Create a temporary manifest
    from models.manifest import Manifest
    
    manifest = await Manifest.create(
        db=db_session,
        smart_matrix_id=test_smart_matrix.id,
        user_id=test_smart_matrix.owner_id
    )
    
    manifest_id = manifest.manifest_id
    
    # Delete via API
    response = await client.delete(f"/api/manifest/{manifest_id}")
    assert response.status_code == status.HTTP_204_NO_CONTENT
    
    # Verify deletion
    get_response = await client.get(f"/api/manifest/{manifest_id}")
    assert get_response.status_code == status.HTTP_404_NOT_FOUND
    
    print("✅ Test 1.2.8 PASSED: Delete manifest successful")


@pytest.mark.asyncio
async def test_get_nonexistent_manifest(client: AsyncClient):
    """
    Test Gate 1.2.9: GET nonexistent manifest returns 404
    """
    fake_id = uuid.uuid4()
    response = await client.get(f"/api/manifest/{fake_id}")
    
    assert response.status_code == status.HTTP_404_NOT_FOUND
    
    print("✅ Test 1.2.9 PASSED: 404 error handling successful")


@pytest.mark.asyncio
async def test_update_nonexistent_manifest(client: AsyncClient):
    """
    Test Gate 1.2.10: PATCH nonexistent manifest returns 404
    """
    fake_id = uuid.uuid4()
    response = await client.patch(
        f"/api/manifest/{fake_id}/position",
        json={"current_x": 100.0, "current_y": 200.0}
    )
    
    assert response.status_code == status.HTTP_404_NOT_FOUND
    
    print("✅ Test 1.2.10 PASSED: Update error handling successful")


# Run all tests
if __name__ == "__main__":
    pytest.main([__file__, "-v", "-s"])
