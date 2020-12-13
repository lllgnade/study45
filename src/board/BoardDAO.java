package board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;

import mybatis.MyBatisConnectionFactory;

public class BoardDAO {

	
	public List<BoardVO> boardlist() throws DataAccessException {
		//빈 필터를 보냄으로써 모든 게시판 조회
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		BoardVO boardFilter = new BoardVO();
		boardFilter.setReadCount(-1); //조회수 필터 초기화
		boardFilter.setBoardAvailable(1); //유효한 글만 조회
		List<BoardVO> boardlist = sqlSession.selectList("mapper.board.searchBoard", boardFilter);
		sqlSession.close();		
		return boardlist;
	}
	
	public List<BoardVO> showBoard(BoardVO boardFilter, int pageNum, int pageSize) throws DataAccessException {
		//페이지 필터를 적용한 모든 게시글 조회
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		
		boardFilter.setReadCount(-1); //조회수 필터 초기화
		boardFilter.setBoardAvailable(1); //유효한 글만 조회
		boardFilter.setPageStart((pageNum-1) * pageSize);
		boardFilter.setPageSize(pageSize);
		
		List<BoardVO> boardlist = sqlSession.selectList("mapper.board.searchBoard", boardFilter);
		sqlSession.close();
		return boardlist;
	}

	
	public BoardVO readOneBoard(int boardNo) throws DataAccessException {
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		//고유 번호 필터 생성
		BoardVO boardFilter = new BoardVO();
		boardFilter.setBoardNo(boardNo);
		boardFilter.setReadCount(-1); //조회수 필터 초기화
		boardFilter.setBoardAvailable(1); //유효한 글만 조회
		//필터로 서치
		BoardVO board = sqlSession.selectOne("mapper.board.searchBoard",boardFilter);
		
		if (board!=null) {
			int result = sqlSession.update("mapper.board.addReadCount",boardFilter);
			sqlSession.commit();
			if(result==0) {
				System.out.println("조회수가 반영되지 않음.");
			}else {
				System.out.println("조회수가 반영됨.");
			}
		}
		sqlSession.close();
		return board;
	}
	
	
	public BoardVO selectThisBoard(String boardNo) throws DataAccessException {
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		//고유 번호 필터 생성
		BoardVO boardFilter = new BoardVO();
		boardFilter.setBoardNo(Integer.parseInt(boardNo));
		boardFilter.setReadCount(-1); //조회수 필터 초기화
		boardFilter.setBoardAvailable(1); //유효한 글만 조회
		//필터로 서치
		BoardVO board = sqlSession.selectOne("mapper.board.searchBoard",boardFilter);
		sqlSession.close();
		return board;
	}

	public List<BoardVO> searchBoard(BoardVO boardFilter) throws DataAccessException {
		//필터로 서치
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		boardFilter.setReadCount(-1); //조회수 필터 초기화
		boardFilter.setBoardAvailable(1); //유효한 글만 조회
		List<BoardVO> boardList = sqlSession.selectList("mapper.board.searchBoard", boardFilter);
		sqlSession.close();
		return boardList;
	}

	public int addBoard(BoardVO boardInfo) throws DataAccessException {

		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		System.out.println("insert 쿼리 실행 전");
		int result= sqlSession.insert("mapper.board.insertBoard", boardInfo);
		System.out.println("insert 쿼리 실행");
		sqlSession.commit();
        sqlSession.close();
		
		if (result == 1) {
			System.out.println("쿼리 성공");
			int inserted_boardNo = (int) boardInfo.getBoardNo();
			System.out.println("insert된 boardNo : "+inserted_boardNo);
			return inserted_boardNo; //insert 성공
		}
		else {
			System.out.println("쿼리 실패");
			return -1; //insert 실패
		}			
	}

	public String updateBoard(BoardVO boardInfo) throws DataAccessException {
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		boardInfo.setReadCount(-1); //조회수 반영x
		boardInfo.setBoardAvailable(-1); //유효성 반영x
		int result = sqlSession.update("mapper.board.updateBoard",boardInfo);
		sqlSession.commit();
        sqlSession.close();
		
		if (result==1)
			return "ok"; //update 성공
		else
			return "fail"; //update 실패
	}
	
	public String discardBoard(BoardVO boardInfo) throws DataAccessException {
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		boardInfo.setReadCount(-1); //조회수 반영x
		boardInfo.setBoardAvailable(0); //글을 유효하지 않게 함
		int result = sqlSession.update("mapper.board.updateBoard",boardInfo);
		sqlSession.commit();
        sqlSession.close();
		
		if (result==1)
			return "ok"; //update 성공
		else
			return "fail"; //update 실패
	}

	
	

	public String deleteBoard(String boardNo) throws DataAccessException {
		SqlSession sqlSession=MyBatisConnectionFactory.getSqlSession();
		int result = sqlSession.delete("mapper.board.deleteBoard",boardNo);
		sqlSession.commit();
        sqlSession.close();
		
		if (result==1)
			return "ok";
		else
			return "fail";
	}

}
