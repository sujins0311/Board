package org.project.commons;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

@Component
public class ServletContextAwareImpl implements ServletContextAware {

	private static ServletContext serlvetContext;
	
	@Override
	public void setServletContext(ServletContext servletContext) {
		ServletContextAwareImpl.serlvetContext = servletContext;
	}

	public static ServletContext getSerlvetContext() {
		return serlvetContext;
	}
	
}