package com.example;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

public class AppTest {
    @Test
    void greetShouldWork() {
        assertEquals("Hello, Jenkins!", App.greet("Jenkins"));
    }
}
