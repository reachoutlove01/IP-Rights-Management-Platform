;; Licensing Agreement Contract

(define-map licenses
  { license-id: uint }
  { copyright-id: uint, licensee: principal, terms: (string-utf8 1000), start-date: uint, end-date: uint, royalty-rate: uint }
)

(define-data-var license-nonce uint u0)

(define-public (create-license (copyright-id uint) (licensee principal) (terms (string-utf8 1000)) (start-date uint) (end-date uint) (royalty-rate uint))
  (let
    ((new-id (+ (var-get license-nonce) u1))
     (copyright-owner (unwrap! (contract-call? .copyright-registration get-copyright-owner copyright-id) (err u404))))
    (asserts! (is-eq tx-sender copyright-owner) (err u403))
    (map-set licenses
      { license-id: new-id }
      { copyright-id: copyright-id, licensee: licensee, terms: terms, start-date: start-date, end-date: end-date, royalty-rate: royalty-rate }
    )
    (var-set license-nonce new-id)
    (ok new-id)
  )
)

(define-read-only (get-license-info (license-id uint))
  (map-get? licenses { license-id: license-id })
)

(define-read-only (is-license-valid (license-id uint))
  (match (map-get? licenses { license-id: license-id })
    license (< block-height (get end-date license))
    false
  )
)

