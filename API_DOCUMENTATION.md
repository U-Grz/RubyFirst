cat > API_DOCUMENTATION.md << 'EOF'
# RubyFirst API Documentation
 
## Base URL
```
Production: http://68.183.45.94:3000/api/v1
Local: http://localhost:3000/api/v1
```
 
## Endpoints
 
### Health Check
```http
GET /api/v1/health
```
Returns 200 OK if API is running.
 
### Users
 
#### List all users
```http
GET /api/v1/users
```
 
**Response:**
```json
[
  {
    "id": 1,
    "email_address": "user@example.com",
    "created_at": "2026-01-21T12:00:00.000Z"
  }
]
```
 
#### Get a specific user
```http
GET /api/v1/users/:id
```
 
#### Create a user
```http
POST /api/v1/users
Content-Type: application/json
 
{
  "user": {
    "email_address": "newuser@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
}
```
 
**Response (201):**
```json
{
  "message": "User created successfully",
  "user": {
    "id": 2,
    "email_address": "newuser@example.com",
    "created_at": "2026-01-21T12:00:00.000Z"
  }
}
```
 
#### Update a user
```http
PATCH /api/v1/users/:id
Content-Type: application/json
 
{
  "user": {
    "email_address": "updated@example.com"
  }
}
```
 
#### Delete a user
```http
DELETE /api/v1/users/:id
```
 
**Response (200):**
```json
{
  "message": "User deleted successfully"
}
```
 
### Authentication
 
#### Login
```http
POST /api/v1/sessions
Content-Type: application/json
 
{
  "email_address": "user@example.com",
  "password": "password123"
}
```
 
**Response (201):**
```json
{
  "message": "Logged in successfully",
  "user": {
    "id": 1,
    "email_address": "user@example.com"
  },
  "session_id": 123
}
```
 
#### Logout
```http
DELETE /api/v1/sessions/:session_id
```
 
## Testing with curl
 
### Create a user:
```bash
curl -X POST http://68.183.45.94:3000/api/v1/users \
  -H "Content-Type: application/json" \
  -d '{"user":{"email_address":"test@example.com","password":"pass123","password_confirmation":"pass123"}}'
```
 
### Get all users:
```bash
curl http://68.183.45.94:3000/api/v1/users
```
 
### Login:
```bash
c
  -H "Content-Type: application/json" \
 
```
 
#
# Error Responses
 
### 404 Not Found
```json
{
  "error": "User not found"
}
```
 
### 401 Unauthorized
```json
{
  "error": "Invalid email or password"
}
```
 
### 422 Unprocessable Entity
```json
{
  "errors": [
    "Email address can't be blank",
    "Password is too short (minimum is 6 characters)"
  ]
}
```
