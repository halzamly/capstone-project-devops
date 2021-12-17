package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Controller class for all webservice endpoints to be used
 *
 * @author Hossam Alzamly,2021-12-17
 */

@Controller
public class WebController {

    @GetMapping("/health")
    public String healthChecker() {
        return "I am fine :)";
    }
}