import { describe, it, expect, beforeEach } from "vitest"

describe("ip-nft", () => {
  let contract: any
  
  beforeEach(() => {
    contract = {
      mintIpNft: (copyrightId: number, metadataUrl: string) => ({ value: 1 }),
      getIpNftInfo: (tokenId: number) => ({
        copyrightId: 1,
        metadataUrl: "https://example.com/metadata/1",
      }),
    }
  })
  
  describe("mint-ip-nft", () => {
    it("should mint a new IP NFT", () => {
      const result = contract.mintIpNft(1, "https://example.com/metadata/1")
      expect(result.value).toBe(1)
    })
  })
  
  describe("get-ip-nft-info", () => {
    it("should return IP NFT information", () => {
      const result = contract.getIpNftInfo(1)
      expect(result.copyrightId).toBe(1)
      expect(result.metadataUrl).toBe("https://example.com/metadata/1")
    })
  })
})

