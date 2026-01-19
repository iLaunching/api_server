"""
Test suite for Manifest model (Tier A - Master Manifest)
Phase 1, Step 1.1 - Test Gate 1.1
"""

import pytest
import uuid
from datetime import datetime
from sqlalchemy.exc import IntegrityError
from models.manifest import Manifest
from models.database_models import SmartHub, SmartMatrix


# Test fixtures
@pytest.fixture
async def test_user_id():
    """Generate a test user ID"""
    return uuid.uuid4()


@pytest.fixture
async def test_smart_hub(db_session, test_user_id):
    """Create a test Smart Hub"""
    hub = SmartHub(
        owner_id=test_user_id,
        name="Test Hub",
        description="Test hub for manifest tests"
    )
    db_session.add(hub)
    await db_session.commit()
    await db_session.refresh(hub)
    return hub


@pytest.fixture
async def test_smart_matrix(db_session, test_smart_hub, test_user_id):
    """Create a test Smart Matrix"""
    matrix = SmartMatrix(
        smart_hub_id=test_smart_hub.id,
        owner_id=test_user_id,
        name="Test Matrix"
    )
    db_session.add(matrix)
    await db_session.commit()
    await db_session.refresh(matrix)
    return matrix


# Test Gate 1.1: Manifest Creation Tests

@pytest.mark.asyncio
async def test_manifest_creation(db_session, test_smart_matrix, test_user_id):
    """
    Test Gate 1.1.1: Verify manifest table exists and can store data
    """
    # Create manifest linked to smart_matrix
    manifest = await Manifest.create(
        db=db_session,
        smart_matrix_id=test_smart_matrix.id,
        user_id=test_user_id
    )
    
    # Assertions
    assert manifest.manifest_id is not None
    assert manifest.smart_matrix_id == test_smart_matrix.id
    assert manifest.user_id == test_user_id
    assert manifest.current_x == 0.0
    assert manifest.current_y == 0.0
    assert manifest.zoom_level == 1.0
    assert manifest.is_active == True
    assert manifest.business_dna == {}
    assert manifest.created_at is not None
    
    print("✅ Test 1.1.1 PASSED: Manifest creation successful")


@pytest.mark.asyncio
async def test_manifest_business_dna(db_session, test_smart_matrix, test_user_id):
    """
    Test Gate 1.1.2: Verify JSONB field stores founder intent
    """
    dna = {
        "intent": "Raise $50k",
        "constraints": {"budget": 5000},
        "style": {"tone": "professional"}
    }
    
    manifest = await Manifest.create(
        db=db_session,
        smart_matrix_id=test_smart_matrix.id,
        user_id=test_user_id,
        business_dna=dna
    )
    
    # Retrieve and verify
    retrieved = await Manifest.get_by_id(db_session, manifest.manifest_id)
    
    assert retrieved is not None
    assert retrieved.business_dna["intent"] == "Raise $50k"
    assert retrieved.business_dna["constraints"]["budget"] == 5000
    assert retrieved.business_dna["style"]["tone"] == "professional"
    
    print("✅ Test 1.1.2 PASSED: Business DNA storage successful")


@pytest.mark.asyncio
async def test_one_manifest_per_smart_matrix(db_session, test_smart_matrix, test_user_id):
    """
    Test Gate 1.1.3: Verify UNIQUE constraint - only one manifest per smart_matrix
    """
    # Create first manifest
    manifest1 = await Manifest.create(
        db=db_session,
        smart_matrix_id=test_smart_matrix.id,
        user_id=test_user_id
    )
    
    # Attempt to create second manifest for same smart_matrix
    with pytest.raises(IntegrityError):
        manifest2 = await Manifest.create(
            db=db_session,
            smart_matrix_id=test_smart_matrix.id,
            user_id=test_user_id
        )
    
    print("✅ Test 1.1.3 PASSED: UNIQUE constraint enforced")


@pytest.mark.asyncio
async def test_cascade_delete(db_session, test_smart_hub, test_user_id):
    """
    Test Gate 1.1.4: Verify manifest is deleted when smart_matrix is deleted
    """
    # Create smart_matrix and manifest
    matrix = SmartMatrix(
        smart_hub_id=test_smart_hub.id,
        owner_id=test_user_id,
        name="Temporary Matrix"
    )
    db_session.add(matrix)
    await db_session.commit()
    await db_session.refresh(matrix)
    
    manifest = await Manifest.create(
        db=db_session,
        smart_matrix_id=matrix.id,
        user_id=test_user_id
    )
    
    manifest_id = manifest.manifest_id
    
    # Delete smart_matrix
    await db_session.delete(matrix)
    await db_session.commit()
    
    # Verify manifest was also deleted (CASCADE)
    deleted_manifest = await Manifest.get_by_id(db_session, manifest_id)
    assert deleted_manifest is None
    
    print("✅ Test 1.1.4 PASSED: CASCADE delete successful")


@pytest.mark.asyncio
async def test_get_by_smart_matrix_id(db_session, test_smart_matrix, test_user_id):
    """
    Test Gate 1.1.5: Verify retrieval by smart_matrix_id (one-to-one)
    """
    # Create manifest
    manifest = await Manifest.create(
        db=db_session,
        smart_matrix_id=test_smart_matrix.id,
        user_id=test_user_id
    )
    
    # Retrieve by smart_matrix_id
    retrieved = await Manifest.get_by_smart_matrix_id(db_session, test_smart_matrix.id)
    
    assert retrieved is not None
    assert retrieved.manifest_id == manifest.manifest_id
    assert retrieved.smart_matrix_id == test_smart_matrix.id
    
    print("✅ Test 1.1.5 PASSED: Retrieval by smart_matrix_id successful")


@pytest.mark.asyncio
async def test_update_position(db_session, test_smart_matrix, test_user_id):
    """
    Test Gate 1.1.6: Verify position update functionality
    """
    # Create manifest
    manifest = await Manifest.create(
        db=db_session,
        smart_matrix_id=test_smart_matrix.id,
        user_id=test_user_id
    )
    
    # Update position
    await manifest.update_position(
        db=db_session,
        current_x=100.5,
        current_y=200.3,
        zoom_level=1.5
    )
    
    # Verify update
    assert manifest.current_x == 100.5
    assert manifest.current_y == 200.3
    assert manifest.zoom_level == 1.5
    
    print("✅ Test 1.1.6 PASSED: Position update successful")


@pytest.mark.asyncio
async def test_update_business_dna(db_session, test_smart_matrix, test_user_id):
    """
    Test Gate 1.1.7: Verify business DNA update functionality
    """
    # Create manifest
    manifest = await Manifest.create(
        db=db_session,
        smart_matrix_id=test_smart_matrix.id,
        user_id=test_user_id,
        business_dna={"intent": "Original"}
    )
    
    # Update business DNA
    new_dna = {"intent": "Updated", "constraints": {"budget": 10000}}
    await manifest.update_business_dna(db=db_session, business_dna=new_dna)
    
    # Verify update
    assert manifest.business_dna["intent"] == "Updated"
    assert manifest.business_dna["constraints"]["budget"] == 10000
    
    print("✅ Test 1.1.7 PASSED: Business DNA update successful")


# Run all tests
if __name__ == "__main__":
    pytest.main([__file__, "-v", "-s"])
