//
// Constant.swift
// Photos
//
//

let ACCESS_KEY = "KOd2V0DZ9UPtF9Ml2guQmzdtIrtRrnA6YAp3dVsMUq8"
let SECRET_KEY = "4X86EuzT9oJRzLspUydO10ifz1h3hK02UWQVm15vMAs"

var BASE_URL: String {
    #if DEBUG
    return "https://api.unsplash.com/"
    #elseif RELEASE
    return "https://api.unsplash.com/"
    #endif
}
