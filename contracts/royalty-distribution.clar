;; Royalty Distribution Contract

(define-map royalty-payments
  { payment-id: uint }
  { license-id: uint, amount: uint, timestamp: uint }
)

(define-data-var payment-nonce uint u0)

(define-public (pay-royalty (license-id uint) (amount uint))
  (let
    ((new-id (+ (var-get payment-nonce) u1))
     (license (unwrap! (contract-call? .licensing-agreement get-license-info license-id) (err u404)))
     (copyright-owner (unwrap! (contract-call? .copyright-registration get-copyright-owner (get copyright-id license)) (err u404))))
    (try! (stx-transfer? amount tx-sender copyright-owner))
    (map-set royalty-payments
      { payment-id: new-id }
      { license-id: license-id, amount: amount, timestamp: block-height }
    )
    (var-set payment-nonce new-id)
    (ok new-id)
  )
)

(define-read-only (get-royalty-payment (payment-id uint))
  (map-get? royalty-payments { payment-id: payment-id })
)

