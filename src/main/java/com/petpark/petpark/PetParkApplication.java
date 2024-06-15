package com.petpark.petpark;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.petpark.controller", "com.petpark.service","com.petpark.dto","com.petpark.mapper"})
@MapperScan("com.petpark.mapper")
public class PetParkApplication {

	public static void main(String[] args) {
		SpringApplication.run(PetParkApplication.class, args);
	}

}