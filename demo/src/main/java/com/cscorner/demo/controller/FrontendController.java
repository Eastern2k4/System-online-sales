package com.cscorner.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FrontendController {

    @GetMapping("/api/status")
    public String getStatus() {
        return "Frontend-focused development mode - Backend functionality will be added after Figma design is complete";
    }
    
    @GetMapping("/api/design-status")
    public String getDesignStatus() {
        return "Currently in Figma design phase - focusing on UI/UX before backend implementation";
    }
}
