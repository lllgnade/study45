package user;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import mybatis.MyBatisConnectionFactory;


public class UserDAO {
	
	
	private static UserDAO dao;

    public static UserDAO getInstance() {
        if(dao==null) {
            synchronized(UserDAO.class) {
                dao=new UserDAO();
            }
        }
        return dao;
    }
    
	//모든 사용자
	public List<UserVO> selectAllUsers(){
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		List<UserVO> userlist = sqlSession.selectList("mapper.user.searchUser", new UserVO());
		sqlSession.close();		
		return userlist;
	}
	//id로 사용자 하나 선택
	public UserVO selectThisUser(String userID){
		
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		UserVO userInfo = (UserVO) sqlSession.selectOne("mapper.user.searchUser", new UserVO(userID));
		sqlSession.close();
		return userInfo;
	}
	//조건으로 사용자 선택
	public List<UserVO> selectUser(UserVO userFilter){
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		List<UserVO> userlist = sqlSession.selectList("mapper.user.searchUser", userFilter);
		sqlSession.close();
		return userlist;
	}
	
	//사용자 추가
	public String addUser(UserVO userInfo){

		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		System.out.println("insert 쿼리 실행 전");
		int result = sqlSession.insert("mapper.user.insertUser", userInfo);
		sqlSession.commit();
		System.out.println("insert 쿼리 실행");
        sqlSession.close();
		
		if (result == 1) {
			System.out.println("insert 성공");
			return "ok"; //insert 성공
		}
		else {
			System.out.println("insert 실패");
			return "fail"; //insert 실패
		}		
	}


	//사용자 정보 수정
	public String updateUser(UserVO userInfo) {
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		int result = sqlSession.update("mapper.user.updateUser",userInfo);
		sqlSession.commit();
        sqlSession.close();
		
		if (result==1)
			return "ok"; //update 성공
		else
			return "fail"; //update 실패
	}

	//사용자 삭제
	public String deleteUser(String userID){
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		int result = sqlSession.delete("mapper.user.deleteUser",userID);
		sqlSession.commit();
        sqlSession.close();
		if (result==1)
			return "ok";
		else
			return "fail";
	}
	
	//해당 유저 존재여부 확인
	public String checkExistUser(UserVO userInfo){
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		String userID = userInfo.getUserID();
		String email = userInfo.getEmail();
		
		if(userID != null) {
			// 해당 ID를 가진 사용자가 있는지 검색
			UserVO selectedUser = (UserVO) sqlSession.selectOne("mapper.user.searchUser", new UserVO(userID));
			sqlSession.close();
			// 검색 결과가 있고 중복된 ID가 있으면 "id" 반환
			if (selectedUser != null) {
				if (selectedUser.getUserID().equals(userID))
					return "id";
			}
		} else if(email != null) {
			// 해당 이메일을 가진 사용자가 있는지 검색
			UserVO userFilter = new UserVO();
			userFilter.setEmail(email);
			UserVO selectedUser = (UserVO) sqlSession.selectOne("mapper.user.searchUser", userFilter);
			sqlSession.close();
			// 검색 결과가 있고 중복된 이메일이 있으면 "email" 반환
			if (selectedUser != null) {
				if (selectedUser.getEmail().equals(email))
					return "email";
			}		
		}
		// 어느 조건에도 해당 안 될 시 "ok" 반환
		return "ok";
	}
	
	//ID, 패스워드 유효성 확인
	public String verifyIdPwd(String userID, String pwd){
		
		// 해당 ID를 가진 사용자가 있는지 검색
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		UserVO selectedUser = (UserVO) sqlSession.selectOne("mapper.user.searchUser", new UserVO(userID));
		sqlSession.close();
		
		
		if (selectedUser != null) {
			// 검색 결과가 있고 ID와 비밀번호가 일치하면 "ok" 반환
			if (selectedUser.getPwd().equals(pwd))
				return "ok";
			// 검색 결과가 있고 비밀번호가 일치하지 않으면 "pwd" 반환
			else {
				return "pwd";
			}
		}
		// 검색 결과가 없으면 "id" 반환
		return "id";
	}

}
