package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;

	public UserDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String id, String password) {
		try {
			conn = dataFactory.getConnection();
			String query = "select password from user_T where id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			System.out.println(query);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString("password").equals(password)) {
					return 1;
				} else {
					return 0;
				}
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return -1;

	}

	public int kakaologin(String id) {
		try {
			conn = dataFactory.getConnection();
			String query = "select * from kakaouser_T where id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			System.out.println(query);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				return 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return -1;

	}

	public void deleteUser(String id, String password) {
		try {
			conn = dataFactory.getConnection();
			String query = "DELETE FROM user_T WHERE id =?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();

		} catch (Exception e) {
		} finally {
			if (conn != null) {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public void addMember(UserVO u) {

		System.out.println("????????????");
		try {
			conn = dataFactory.getConnection();
			String id = u.getId();
			String password = u.getPwd();
			String nickname = u.getNickname();
			String phone_number = u.getPhone_number();
			String profile_img = u.getProfile_img();
			String addr = u.getAddr();
			String detail_addr = u.getDetail_addr();
			String query = "INSERT INTO user_T(id, password, nickname, phone_number, profile_img, addr, detail_addr)"
					+ " VALUES(?, ? ,? ,?,?,?,?)";
			System.out.println(query);

			System.out.println("??????id=" + id);
			System.out.println("??????addr=" + addr);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, nickname);
			pstmt.setString(4, phone_number);
			pstmt.setString(5, profile_img);
			pstmt.setString(6, addr);
			pstmt.setString(7, detail_addr);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public void updateMember(UserVO u) {
        try {
                conn = dataFactory.getConnection();
                String nickname = u.getNickname();
                String phone_number = u.getPhone_number();
                String profile_img = u.getProfile_img();
                String addr = u.getAddr();
                String detail_addr = u.getDetail_addr();
                String id=u.getId();
                
                String query = "UPDATE user_T SET nickname=?, phone_number=?, profile_img=?, addr=?, detail_addr=? where id=?";
                System.out.println(query);
                
                System.out.println("??????????????????=" + nickname);
                System.out.println(addr);
                System.out.println(profile_img);
                System.out.println(id);
                
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, nickname);
                pstmt.setString(2, phone_number);
                pstmt.setString(3, profile_img);
                pstmt.setString(4, addr);
                pstmt.setString(5, detail_addr);
                pstmt.setString(6, id);
                System.out.println("????????????");
                
        }catch(SQLException e) {
                e.printStackTrace();
        }finally{
                try {
                        pstmt.executeUpdate();
                        System.out.println("???????????????");
                        pstmt.close();
                        conn.close();
                } catch (SQLException e) {
                        e.printStackTrace();
                }
        }
	}

	public void addKakaoMember(KakaouserVO u) {

		System.out.println("????????????");
		try {
			conn = dataFactory.getConnection();
			String id = u.getId();
			String nickname = u.getNickname();
			// String phone_number = u.getPhone_number();
			String profile_img = u.getProfile_img();
			// String addr = u.getAddr();
			// String detail_addr = u.getDetail_addr();
			String query = "INSERT INTO kakaouser_T(id, nickname,profile_img)" + " VALUES(?, ?,?)";
			System.out.println(query);

			System.out.println("????????????id=" + id);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, nickname);
			pstmt.setString(3, profile_img);
			// pstmt.setString(4, phone_number);
			// pstmt.setString(5, profile_img);
			// pstmt.setString(6, addr);
			// pstmt.setString(7, detail_addr);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public int checkId(String id) {
		int idCheck = 0;
		try {
			conn = dataFactory.getConnection();
			String query = "select * from user_T where id=?";
			System.out.println("prepareStatement: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				idCheck = 0; // ?????? ???????????? ??????, ?????? ?????????
			} else {
				idCheck = 1; // ???????????? ?????? ??????, ?????? ??????
			}
			conn.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return idCheck;
	}

	public int checkNickname(String nickname) {
		int nickCheck = 0;
		try {
			conn = dataFactory.getConnection();
			String query = "select * from user_T where nickname=?";
			System.out.println("prepareStatement: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, nickname);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next() || nickname.equals("")) {
				nickCheck = 0;
			} else {
				nickCheck = 1;
			}
			conn.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return nickCheck;
	}

	public int checkPassword(String password) {
        int pwdCheck=0;
        try {
                conn = dataFactory.getConnection();
                String query="select * from user_T where password=?";
                System.out.println("prepareStatement: " + query);
                pstmt=conn.prepareStatement(query);
                pstmt.setString(1, password);
                ResultSet rs=pstmt.executeQuery();
                if(rs.next()||password.equals("")) {
                        pwdCheck=0;
                }else {
                        pwdCheck=1;
                }
                rs.close();
                
                
        } catch (Exception e) {
                e.printStackTrace();
        }finally {
                try {
                        pstmt.close();
                        conn.close();
                } catch (Exception e2) {
                }
        }
        return pwdCheck;
}
	public UserVO readUser(String id) {
		UserVO user = new UserVO();
		try {

			conn = dataFactory.getConnection();
			String query = "select * from user_t where id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			System.out.println(query);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				id = rs.getString("id");
				String password = rs.getString("password");
				String nickname = rs.getString("nickname");
				String phone_number = rs.getString("phone_number");
				String profile_img = rs.getString("profile_img");
				String addr = rs.getString("addr");
				String detail_addr = rs.getString("detail_addr");

				System.out.println("DAO=" + id);
				System.out.println(password);
				System.out.println(nickname);
				System.out.println(phone_number);
				System.out.println(profile_img);
				System.out.println(addr);
				System.out.println(detail_addr);

				user.setId(id);
				user.setPwd(password);
				user.setNickname(nickname);
				user.setPhone_number(phone_number);
				user.setProfile_img(profile_img);
				user.setAddr(detail_addr);
				user.setDetail_addr(detail_addr);

			}rs.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return user;
	}

	public KakaouserVO readkakaoUser(String id) {
		KakaouserVO user = new KakaouserVO();
		try {

			System.out.println("????????????????????? ??????");
			System.out.println("??????=" + id);
			conn = dataFactory.getConnection();
			String query = "select * from kakaouser_T where id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			System.out.println(query);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				System.out.println("rs???????????????");
				id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String phone_number = rs.getString("phone_number");
				String profile_img = rs.getString("profile_img");
				String addr = rs.getString("addr");
				String detail_addr = rs.getString("detail_addr");

				System.out.println("DAO=" + id);
				System.out.println(nickname);
				System.out.println(phone_number);
				System.out.println(profile_img);
				System.out.println(addr);
				System.out.println(detail_addr);

				user.setId(id);
				user.setNickname(nickname);
				user.setPhone_number(phone_number);
				user.setProfile_img(profile_img);
				user.setAddr(detail_addr);
				user.setDetail_addr(detail_addr);
			}rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return user;

	}

}