UPDATE tbl_chat_history
SET document_json = '{
  "type": "doc",
  "content": [
    {
      "type": "paragraph",
      "content": [
        {
          "type": "text",
          "text": "System Initialized: Master Control Node is now online. DNA and OKRs are synchronized."
        }
      ]
    },
    {
      "type": "aiTurn",
      "attrs": {
        "turnId": "turn_1739660000000_test",
        "isComplete": true,
        "timestamp": "2026-02-16T10:00:00.000Z",
        "summary": "",
        "cites": []
      },
      "content": [
        {
          "type": "query",
          "attrs": {
            "query_id": "q_test_1",
            "user_id": "user_test",
            "user_first_name": "User",
            "user_avatar_type": "text",
            "user_avatar_text": "U"
          },
          "content": [
            {
              "type": "text",
              "text": "What is the current status of the Website Traffic loop?"
            }
          ]
        },
        {
          "type": "response",
          "attrs": {
            "responseId": "res_123",
            "isComplete": true,
            "timestamp": "2026-02-16T10:00:01.000Z"
          },
          "content": [
            {
              "type": "paragraph",
              "content": [
                {
                  "type": "text",
                  "text": "The loop is active. Current traffic is at 1.2k/hr, meeting the Master OKR of >1k/hr. I have indexed the latest logs via the MCP server."
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}'::jsonb;
