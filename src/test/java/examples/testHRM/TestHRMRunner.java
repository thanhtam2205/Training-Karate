package examples.testHRM;

import com.intuit.karate.junit5.Karate;

public class TestHRMRunner {
    @Karate.Test
    Karate getAllJob() {
        return Karate.run("getAllJob").relativeTo(getClass());
    }
}
