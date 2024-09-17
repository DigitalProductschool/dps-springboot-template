package demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;

@CrossOrigin
@RestController
public class HelloController {

    @CrossOrigin
    @GetMapping("/api/endpoint")
    public String helloGradle() {
        return "Hello Gradle from endpoint!";
    }

    @GetMapping("/api/prtest")
    public String helloPRTest() {
        return "Hello, your pull request got updated!";
    }
}