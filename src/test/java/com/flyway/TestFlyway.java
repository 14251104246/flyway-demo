package com.flyway;

import org.flywaydb.core.Flyway;
import org.junit.Test;

public class TestFlyway {
    @Test
    public void flyway(){
        // Create the Flyway instance
        Flyway flyway = new Flyway();

        // Point it to the database
        flyway.setDataSource("jdbc:mysql://127.0.0.1:3306/flyway?useLegacyDatetimeCode=false&serverTimezone=Asia/Hong_Kong&useSSL=false", "root", "123456");

        // Start the migration
        flyway.migrate();
    }
}
