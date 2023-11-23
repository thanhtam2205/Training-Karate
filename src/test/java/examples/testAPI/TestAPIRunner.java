package examples.testAPI;
import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit5.Karate;
import org.junit.runner.RunWith;

public class TestAPIRunner {
    @Karate.Test
    Karate getAPI() {
        return Karate.run("getAPI").relativeTo(getClass());
    }
    @Karate.Test
    Karate postAPI() {
        return Karate.run("postAPI").relativeTo(getClass());
    }
    @Karate.Test
    Karate putAPI() {
        return Karate.run("putAPI").relativeTo(getClass());
    }
}
