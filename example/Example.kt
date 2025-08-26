// Example Kotlin file to test ktfmt formatting
package com.example

import java.util.*

class Example {
    fun formatMe(name: String, age: Int, items: List<String>): String {
        val result = StringBuilder()
        result.append("Hello, $name!")
        result.append(" You are $age years old.")
        
        if (items.isNotEmpty()) {
            result.append(" Your items: ")
            items.forEach { item ->
                result.append("$item, ")
            }
        }
        
        return result.toString().trimEnd(',', ' ')
    }
    
    data class Person(val name: String, val age: Int, val email: String?)
    
    fun processData(): Map<String, Any> {
        return mapOf(
            "timestamp" to Date(),
            "version" to "1.0.0",
            "features" to listOf("formatting", "linting", "validation")
        )
    }
}