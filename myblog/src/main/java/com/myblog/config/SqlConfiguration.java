package com.myblog.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import net.sf.log4jdbc.sql.jdbcapi.DriverSpy;

//import com.mysql.cj.jdbc.Driver;

@Configuration
@EnableTransactionManagement
@ComponentScan(basePackages = {"com.myblog.*"})
public class SqlConfiguration {
	
	@Bean 
	public PlatformTransactionManager txManager() {
		return new DataSourceTransactionManager(dataSource()); 
	}
	
	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setUsername("root");
		dataSource.setPassword("root");
		dataSource.setUrl("jdbc:log4jdbc:mysql://127.0.0.1:3306/myblog?useSSL=false&allowPublicKeyRetrieval=true&amp&serverTimezone=Asia/Seoul");
		dataSource.setDriverClassName(DriverSpy.class.getName());
		return dataSource;
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(dataSource());
		sqlSessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver()
				.getResources("classpath:com/myblog/*Mapper.xml"));
		return sqlSessionFactoryBean.getObject();
	}
	
	@Bean 
	public SqlSession sqlSession() throws Exception {
		SqlSession sqlSession = new SqlSessionTemplate(sqlSessionFactory());
		return sqlSession;
	}
}
