package com.myblog.config;

import org.apache.tiles.web.util.TilesDispatchServlet;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;


@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"com.myblog.config","com.myblog.web"})
public class BoardConfiguration implements WebMvcConfigurer{
	
	@Override
    public void addViewControllers(ViewControllerRegistry registry) { //첫 페이지를 지정해줌
        registry.addViewController("/").setViewName("redirect:/board/getBoardList");
    }
	
	@Override
	 public void addResourceHandlers(ResourceHandlerRegistry registry) {
		 registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }
	 
	@Bean
	public InternalResourceViewResolver internerViewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		viewResolver.setOrder(2);
		return viewResolver;
	}
	
	@Bean
	public UrlBasedViewResolver tilesViewResolver() {
		UrlBasedViewResolver tilesView = new UrlBasedViewResolver();
		tilesView.setViewClass(TilesView.class);
		tilesView.setOrder(1);
		return tilesView;
	}
	
	@Bean
	public TilesConfigurer tilesConfigurer() {
		TilesConfigurer tiles = new TilesConfigurer();
		tiles.setDefinitions("/WEB-INF/tiles/tiles.xml");
		return tiles;
	}
	
}
