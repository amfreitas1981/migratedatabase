package com.example.migratedatabase;

import liquibase.integration.spring.SpringLiquibase;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.context.ApplicationContext;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
@ActiveProfiles("test") // Use o perfil de teste para evitar qualquer impacto em produção
public class MigrateDatabaseApplicationTests {

	@Autowired
	private ApplicationContext applicationContext;

	@Autowired
	private SpringLiquibase springLiquibase;

	@Test
	public void contextLoads() {
		// Verifica se o contexto da aplicação foi carregado corretamente
		assertNotNull(applicationContext);
	}

	@Test
	public void liquibaseBeanShouldBeInitialized() throws Exception {
		// Verifica se o SpringLiquibase foi inicializado corretamente
		assertNotNull(springLiquibase);
		// Executa o Liquibase para garantir que a migração será aplicada
		springLiquibase.afterPropertiesSet();
	}

	@Test
	public void liquibaseMigrationShouldRun() throws Exception {
		// Verifica se a execução do Liquibase ocorre sem erros
		try {
			springLiquibase.afterPropertiesSet();
			// Se não lançar nenhuma exceção, o Liquibase executou com sucesso
			System.out.println("Liquibase scripts applied successfully.");
		} catch (Exception e) {
			// Caso haja erro, o teste falhará
			System.err.println("Error during Liquibase migration: " + e.getMessage());
			throw e;
		}
	}

	@Test
	public void mainMethodShouldRun() {
		// Invoca o metodo main da classe principal explicitamente para cobrir o código
		try {
			String[] args = {};
			// Executa o metodo main() da classe principal MigrateDatabaseApplication
			SpringApplication.run(MigrateDatabaseApplication.class, args);
			// Se o metodo main() executar sem erros, o teste passará
			System.out.println("Spring Boot application started successfully.");
		} catch (Exception e) {
			// Caso o metodo main falhe, o teste falhará
			System.err.println("Error during Spring Boot application startup: " + e.getMessage());
			throw e;
		}
	}

	@Test
	public void mainMethodShouldRunError() {
		// Invoca o metodo main da classe principal MigrateDatabaseApplication
		assertDoesNotThrow(() -> {
			String[] args = {};
			SpringApplication.run(MigrateDatabaseApplication.class, args);
		});
	}

	@Test
	void mainMethodStartsApplication() {
		assertDoesNotThrow(() -> MigrateDatabaseApplication.main(new String[]{}), "Main method should start the application without throwing exceptions");
	}

	@Test
	void applicationHasExpectedBeans() {
		assertTrue(applicationContext.containsBean("migrateDatabaseApplication"), "Application should contain migrateDatabaseApplication bean");
	}

	@Test
	void springBootApplicationContextLoads() {
		assertNotNull(applicationContext, "Application context should not be null");
		assertTrue(applicationContext.containsBean("org.springframework.context.annotation.internalConfigurationAnnotationProcessor"),
				"Application should contain internalConfigurationAnnotationProcessor bean");
	}
}
