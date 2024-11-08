package com.example.migratedatabase;

import liquibase.integration.spring.SpringLiquibase;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class MigrateDatabaseApplication {

	public static void main(String[] args) {
		SpringApplication.run(MigrateDatabaseApplication.class, args);
	}

	@Bean
	CommandLineRunner runLiquibase(SpringLiquibase liquibase) {
		return args -> {
			liquibase.afterPropertiesSet(); // Executa o Liquibase ao iniciar a aplicação
			System.out.println("Liquibase scripts applied successfully.");
		};
	}

}
