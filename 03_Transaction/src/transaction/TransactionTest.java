package transaction;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;

import config.ServerInfo;

public class TransactionTest {

	public static void main(String[] args) {
		try {
			// 1. 드라이버 로딩
			Class.forName(ServerInfo.DRIVER_NAME);

			// 2. 데이터베이스 연결
			Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
			System.out.println("DB Connection...");
			
			// 트랜잭션 시작!
			conn.setAutoCommit(false); // 커밋 자동으로 멈춤, 여기서 추가해도 오라클에서 추가 안되어있음

			// 3. PreparedStatement
			String query1 = "INSERT INTO customer(name, age, address) VALUES(?, ? ,?)";
			PreparedStatement st = conn.prepareStatement(query1);
			
			// 4. 쿼리문1 실행
			st.setString(1, "김경미");
			st.setInt(2, 17);
			st.setString(3, "서울 강남구");
			
			int result = st.executeUpdate();
			
			// savepoint
			Savepoint savepoint = conn.setSavepoint("A"); 
			
			// query2
			String query2 = "SELECT * FROM customer WHERE name = ? ";
			PreparedStatement st2 = conn.prepareStatement(query2);
			
			st2.setString(1, "홍수민");
			
			ResultSet rs = st2.executeQuery();
			
			if(rs.next()) {
				conn.rollback(savepoint); // savepoint로 돌아가서 rollback되기 때문에 쿼리문1은 실행됨(savepoint)가 없을시 insert 불가
				System.out.println("회원 정보가 있으므로 rollback!!");
			} else {
				conn.commit();
				System.out.println("회원 정보가 없으므로 commit!!");
			}
			
			// 트랜잭션 처리를 다시 원래대로 돌려놓음!
//			conn.setAutoCommit(true);
			
//			System.out.println(result + "명 추가!");
			
			
			
			if(result == 1) {
				conn.commit();
			} else {
				conn.rollback();
			}
			
			st.close(); // 자원 반납
			conn.close();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		
	}

}
