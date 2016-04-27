package com.gcit.lms;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.lms.dao.AuthorDAO;
import com.lms.dao.BookCopiesDAO;
import com.lms.dao.BookDAO;
import com.lms.dao.BookLoansDAO;
import com.lms.dao.BorrowerDAO;
import com.lms.dao.GenreDAO;
import com.lms.dao.LibraryBranchDAO;
import com.lms.dao.PublisherDAO;
import org.springframework.jdbc.core.JdbcTemplate;
@EnableTransactionManagement
@Configuration
public class LMSConfig {

	
	private String driver = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/library";
	private String user = "root";
	private String pass = "5883";
	
	@Bean
	public BasicDataSource dataSource(){
		BasicDataSource ds = new BasicDataSource();
		
		ds.setDriverClassName(driver);
		ds.setUrl(url);
		ds.setUsername(user);
		ds.setPassword(pass);
		
		return ds;
	}
	
	@Bean
	public PlatformTransactionManager txManager(){
		DataSourceTransactionManager tx = new DataSourceTransactionManager();
		tx.setDataSource(dataSource());
		return tx;
		
	}
	
	@Bean
	AuthorDAO aDAO(){
		AuthorDAO adao = new AuthorDAO();
		return adao;
	}
	//do the same for all dao.
	@Bean
	BookDAO bDAO(){
		BookDAO bdao = new BookDAO();
		return bdao;
	}
	@Bean
	PublisherDAO pDAO(){
		PublisherDAO pdao = new PublisherDAO();
		return pdao;
	}
	
	@Bean
	BorrowerDAO brDAO(){
		BorrowerDAO brdao = new BorrowerDAO();
		return brdao;
	}
	
	@Bean
	LibraryBranchDAO lbDAO(){
		LibraryBranchDAO lbDAO = new LibraryBranchDAO();
		return lbDAO;
	}
	
	@Bean
	GenreDAO gDAO(){
		GenreDAO gdao = new GenreDAO();
		return gdao;
	}
	
	@Bean
	BookLoansDAO blDAO(){
		BookLoansDAO bldao = new BookLoansDAO();
		return bldao;
	}
	
	@Bean
	BookCopiesDAO bcDAO(){
		BookCopiesDAO bcdao = new BookCopiesDAO();
		return bcdao;
	}
	
	protected JdbcTemplate  getJdbcTemplate()
	
	    {
	
	       final JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource());
	
	       jdbcTemplate.setFetchSize(Integer.MIN_VALUE);
	
	       return jdbcTemplate;
	       
	
	    }

	public JdbcTemplate template(){
		JdbcTemplate template = new JdbcTemplate();
		template.setDataSource(dataSource());
		return template;
	}
	  /*public int queryForInt(String sql, Object... args) throws DataAccessException {
		Number number = queryForObject(sql, args, Integer.class);
		return (number != null ? number.intValue() : 0);
	  }*/
	
}
