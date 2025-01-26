;; Intellectual Property NFT Contract

(define-non-fungible-token ip-nft uint)

(define-map ip-nft-info
  { token-id: uint }
  { copyright-id: uint, metadata-url: (string-ascii 256) }
)

(define-data-var token-nonce uint u0)

(define-public (mint-ip-nft (copyright-id uint) (metadata-url (string-ascii 256)))
  (let
    ((new-id (+ (var-get token-nonce) u1))
     (copyright-owner (unwrap! (contract-call? .copyright-registration get-copyright-owner copyright-id) (err u404))))
    (asserts! (is-eq tx-sender copyright-owner) (err u403))
    (try! (nft-mint? ip-nft new-id tx-sender))
    (map-set ip-nft-info
      { token-id: new-id }
      { copyright-id: copyright-id, metadata-url: metadata-url }
    )
    (var-set token-nonce new-id)
    (ok new-id)
  )
)

(define-read-only (get-ip-nft-info (token-id uint))
  (map-get? ip-nft-info { token-id: token-id })
)

