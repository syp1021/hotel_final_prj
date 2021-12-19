package kr.co.sist.dao;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * Spring JDBC 를 사용하여 DBMS 작업을 하기 위해 JdbcTemplate을 반환하는 일
 * @author user
 *
 */
public class GetJdbcTemplate {
	private static GetJdbcTemplate gjt;
	
	private GetJdbcTemplate() {
	}
	
	public static GetJdbcTemplate getInstance() {
		if( gjt == null) {
			gjt = new GetJdbcTemplate();
		}//end if
		return gjt;
	}//getInstance
	
	private ApplicationContext ac;
	
	private ApplicationContext getAc() {
		// ac가 객체가 생성되어 있지 않았거나, ac 활성화 상태가 아니라면
		if( ac == null || ( ac != null && !((ClassPathXmlApplicationContext)ac).isActive() ) ) {
			// Spring Container를 생성 -> 연속성을 가지고 계속 쓰기 위해
			ac = new ClassPathXmlApplicationContext("kr/co/sist/dao/applicationContext.xml");
		}//end if
		return ac;
	}//getAc
	
	
	/**
	 * DBCP 기반의 DBMS 작업을 수행하는 org.springframework.jdbc.core.JdbcTemplate
	 * 클래스의 객체를 반환하는 일
	 * @return
	 */
	public JdbcTemplate getJdbcTemplate() {
		JdbcTemplate jt = null;
		
		ApplicationContext ac = getAc();
		
		jt = ac.getBean(JdbcTemplate.class);
		
		
		return jt;
	}//getJdbcTemplate

	
	public void closeAc() {
		// Spring Container에서 메모리 누수가 발생하지 않도록 닫아준다. 
		if( ac != null ) {
			((ClassPathXmlApplicationContext)ac).close();
		}//end if
	}//closeAc
	
	
}//class
