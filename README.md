# CivicTrack Smart Contract

CivicTrack is a decentralized civic issue reporting system built on the Stacks blockchain using Clarity smart contracts. It allows users to submit, track, and resolve civic issues transparently.

## Features

- **Submit Issues:** Citizens can report civic issues with type and location.
- **Track Issues:** Each issue is stored with a unique ID, reporter, status, and timestamp.
- **Resolve Issues:** Only the contract owner can resolve (close) issues.
- **Read-Only Queries:** Retrieve issue details and total issue count.

## Data Structures

### Issue Map

| Field       | Type               | Description                  |
|-------------|--------------------|------------------------------|
| `id`        | `uint`             | Unique issue identifier      |
| `reporter`  | `principal`        | Address of the reporter      |
| `issue-type`| `string-ascii(30)` | Type/category of the issue   |
| `location`  | `string-ascii(50)` | Location description         |
| `status`    | `string-ascii(10)` | "OPEN" or "CLOSED"           |
| `timestamp` | `uint`             | Block height when submitted  |

## Public Functions

### `submit-issue`

```clarity
(define-public (submit-issue (issue-type (string-ascii 30)) (location (string-ascii 50))) ...)
```
- **Description:** Submits a new civic issue.
- **Returns:** `(ok issue-id)` on success, `(err u403)` on invalid input.

### `resolve-issue`

```clarity
(define-public (resolve-issue (issue-id uint)) ...)
```
- **Description:** Resolves (closes) an existing issue.
- **Access:** Only contract owner.
- **Returns:** `(ok ...)` on success, `(err ...)` on error.

## Read-Only Functions

### `get-issue`

```clarity
(define-read-only (get-issue (issue-id uint)) ...)
```
- **Description:** Returns details of a specific issue.

### `get-issue-count`

```clarity
(define-read-only (get-issue-count) ...)
```
- **Description:** Returns the total number of issues submitted.

## Error Codes

- `u403`: Invalid input (string too long or empty)
- `"UNAUTHORIZED"`: Only contract owner can resolve issues
- `"INVALID_ISSUE_ID"`: Issue ID does not exist
- `"ISSUE_NOT_FOUND"`: Issue not found in the map

## Development

### Requirements

- [Clarity Language](https://docs.stacks.co/write-smart-contracts/clarity-lang)
- [Clarinet](https://docs.hiro.so/clarinet/get-started) (for local development and testing)

### Setup

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/CivicTrack.git
    cd CivicTrack
    ```
2. Install dependencies and tools as needed.
3. Test the contract:
    ```sh
    clarinet test
    ```

## Security

- Only the contract owner can resolve issues.
- Input validation prevents malformed or oversized data.


**Author:** OKOH MARVELLOUS
**Contact:** [okohmarvellousehiaghi@gmail.com)
