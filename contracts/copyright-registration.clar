;; Copyright Registration Contract

(define-non-fungible-token copyright uint)

(define-map copyright-info
  { copyright-id: uint }
  { creator: principal, title: (string-ascii 100), description: (string-utf8 500), creation-date: uint, registration-date: uint }
)

(define-data-var copyright-nonce uint u0)

(define-public (register-copyright (title (string-ascii 100)) (description (string-utf8 500)) (creation-date uint))
  (let
    ((new-id (+ (var-get copyright-nonce) u1))
     (creator tx-sender))
    (try! (nft-mint? copyright new-id creator))
    (map-set copyright-info
      { copyright-id: new-id }
      { creator: creator, title: title, description: description, creation-date: creation-date, registration-date: block-height }
    )
    (var-set copyright-nonce new-id)
    (ok new-id)
  )
)

(define-read-only (get-copyright-info (copyright-id uint))
  (map-get? copyright-info { copyright-id: copyright-id })
)

(define-read-only (get-copyright-owner (copyright-id uint))
  (nft-get-owner? copyright copyright-id)
)

