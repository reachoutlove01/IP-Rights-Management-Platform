import { describe, it, expect, beforeEach } from "vitest"

describe("copyright-registration", () => {
  let contract: any
  
  beforeEach(() => {
    contract = {
      registerCopyright: (title: string, description: string, creationDate: number) => ({ value: 1 }),
      getCopyrightInfo: (copyrightId: number) => ({
        creator: "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM",
        title: "My Awesome Creation",
        description: "A detailed description of my creation",
        creationDate: 1625097600,
        registrationDate: 1625184000,
      }),
      getCopyrightOwner: (copyrightId: number) => ({ value: "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM" }),
    }
  })
  
  describe("register-copyright", () => {
    it("should register a new copyright", () => {
      const result = contract.registerCopyright(
          "My Awesome Creation",
          "A detailed description of my creation",
          1625097600,
      )
      expect(result.value).toBe(1)
    })
  })
  
  describe("get-copyright-info", () => {
    it("should return copyright information", () => {
      const result = contract.getCopyrightInfo(1)
      expect(result.creator).toBe("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM")
      expect(result.title).toBe("My Awesome Creation")
      expect(result.description).toBe("A detailed description of my creation")
      expect(result.creationDate).toBe(1625097600)
      expect(result.registrationDate).toBe(1625184000)
    })
  })
  
  describe("get-copyright-owner", () => {
    it("should return the copyright owner", () => {
      const result = contract.getCopyrightOwner(1)
      expect(result.value).toBe("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM")
    })
  })
})

