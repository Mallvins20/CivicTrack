;; ----------------------------
;; CIVICTRACK: Civic Issue Reporting System
;; Version: 1.0
;; Author: YourName
;; ----------------------------

(define-constant contract-owner 'SP000000000000000000002Q6VF78)

(define-data-var issue-counter uint u0)

(define-map issues
  { id: uint }
  {
    reporter: principal,
    issue-type: (string-ascii 30),
    location: (string-ascii 50),
    status: (string-ascii 10),
    timestamp: uint
  }
)

;; ----------------------------
;; PUBLIC FUNCTIONS
;; ----------------------------

;; Submit a new civic issue
(define-public (submit-issue (issue-type (string-ascii 30)) (location (string-ascii 50)))
  (begin
    (let
      (
        (new-id (+ (var-get issue-counter) u1))
      )
      (asserts! (is-some (as-max-len? issue-type u30)) (err u403))
      (asserts! (is-some (as-max-len? location u50)) (err u403))
      (map-set issues {id: new-id}
        {
          reporter: tx-sender,
          issue-type: issue-type,
          location: location,
          status: "OPEN",
          timestamp: burn-block-height
        }
      )
      (var-set issue-counter new-id)
      (ok new-id)
    )
  )
)

;; Resolve an existing issue (only contract owner)
(define-public (resolve-issue (issue-id uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err "UNAUTHORIZED"))
    (asserts! (<= issue-id (var-get issue-counter)) (err "INVALID_ISSUE_ID"))
    (let ((issue (unwrap! (map-get? issues {id: issue-id}) (err "ISSUE_NOT_FOUND"))))
      (begin
        (map-set issues {id: issue-id}
          {
            reporter: (get reporter issue),
            issue-type: (get issue-type issue),
            location: (get location issue),
            status: "CLOSED",
            timestamp: (get timestamp issue)
          }
        )
        (ok "Issue resolved successfully.")
      )
    )
  )
)

;; ----------------------------
;; READ-ONLY FUNCTIONS
;; ----------------------------

(define-read-only (get-issue (issue-id uint))
  (map-get? issues {id: issue-id})
)

(define-read-only (get-issue-count)
  (ok (var-get issue-counter))
)
