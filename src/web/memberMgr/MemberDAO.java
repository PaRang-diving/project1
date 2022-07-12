package web.memberMgr;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @author SOON
 *
 */
public class MemberDAO {
	
//	static MemberDAO instance;
//	
//	private MemberDAO() {}
//	
//	public static MemberDAO getInstance() {
//		if(instance == null) {
//			instance = new MemberDAO();
//		}
//		return instance;
//	}

	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	void connect() {
		System.out.println("DB연결시도");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/jspdb", "root", "1q1q2w2w");
		} catch (ClassNotFoundException e) {

			System.out.println("conn Errror Calss Found Ex");
			System.out.println(e.getMessage());
		} catch (SQLException e) {

			System.out.println("conn Error SQL Exception");
			System.out.println(e.getMessage());
		}
	}

	void disconnect() {

		System.out.println("disConn Start");

		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}


	public boolean insert(MemberVO vo) {

		System.out.println("DB 인서트 시도");

		connect();

		String sql2 =

				"INSERT INTO MEMBERS " + "( " + "	member_id " + "	,member_pw " + "	,member_name "
						+ "	,member_age " + "	,member_gender " + "	,member_email " + ") " + "VALUES (?,?,?,?,?,?)";

//		 System.out.println("泥댄겕 ::: sql :::: "+ sql );

		boolean insertRslt = false;

		try {
			stmt = conn.prepareStatement(sql2);

			stmt.setString(1, vo.getMember_id());
			stmt.setString(2, vo.getMember_pw());
			stmt.setString(3, vo.getMember_name());
			stmt.setInt(4, vo.getMember_age());
			stmt.setString(5, vo.getMember_gender());
			stmt.setString(6, vo.getMember_email());

			stmt.executeUpdate();
			insertRslt = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return insertRslt;
		} finally {
			
			disconnect();
		}

		return insertRslt;
	}

	
	public int memberCheck(String member_id) {

		System.out.println("멤버 검색(id)");
		
		int result = -1;
		try {
			StringBuilder sql = new StringBuilder();

			
			sql.append("SELECT * FROM members WHERE member_id = '" + member_id + "'");

			connect();

			PreparedStatement stmt = null;
			
			System.out.println("멤버 아이디 : "+member_id);
			System.out.println("SQL 확인 :  "+sql.toString());
			
			stmt = conn.prepareStatement(sql.toString());

			rs = stmt.executeQuery();

			if (rs.next()) {
				
				System.out.println("next is true");
				
				if (rs.getString("member_id").equals(member_id)) {
					result = 1; 
				} else {
					result = -1; 
				}
			} else { 
				
				System.out.println("next is false");
				
				result = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("memberCheck() Exception!");
		} finally {
			disconnect();
		}
		return result;
	}

	public boolean updateDB(MemberVO vo) {
		connect();

		String sql = "update members set member_id=?, member_pw=?, member_name=?, member_age=?,"
				+ " member_gender=?, member_email=? where member_id=?";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, vo.getMember_id());
			stmt.setString(2, vo.getMember_pw());
			stmt.setString(3, vo.getMember_name());
			stmt.setInt(4, vo.getMember_age());
			stmt.setString(5, vo.getMember_gender());
			stmt.setString(6, vo.getMember_email());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean delete(String member_id) {
		connect();

		String sql = "delete from members where member_id=?";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member_id);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public ArrayList<MemberVO> getDBList() {

		connect();
		ArrayList<MemberVO> datas = new ArrayList<MemberVO>();

		String sql = "select * from members";
		try {
			stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				MemberVO member = new MemberVO();

				member.setMember_id(rs.getString("member_id"));
				member.setMember_pw(rs.getString("member_pw"));
				member.setMember_name(rs.getString("member_name"));
				member.setMember_age(rs.getInt("member_age"));
				member.setMember_gender(rs.getString("member_gender"));
				member.setMember_email(rs.getString("member_email"));
				datas.add(member);
			}
			rs.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}
	
	public boolean loginCheck(String member_id, String member_pw) {
		connect();
		boolean check = false;
		
		
		String sql = "SELECT * FROM members WHERE member_id = ? and member_pw = ?";
		
		try {
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member_id);
			stmt.setString(2, member_pw);
			rs = stmt.executeQuery();
			check = rs.next();
			
		} catch (Exception e) {
			System.out.println("loginCheck() Exception!" + e);
		} finally {
			disconnect();
		}
		return check;
		
		
	}

}
