package board;

public class BoardVO {
	
	private int boardNo; // PRIMARY KEY. AUTO INCREMENT
	private String boardType; // 게시판 종류. not null
	private String userID; //작성자 ID. FOREIGN KEY(USER). not null
	private String title; //게시글 제목. not null
	private String contents; //게시글 내용
	private String regDate; // 작성일자. DEFAULT CURRENT_TIMESTAMP
	private int readCount=0; //조회수. not null DEFAULT 0
	private int boardAvailable=1; //게시물 사용가능여부. not null DEFAULT 1. 삭제시 0, DB에는 저장.
	
	//유저 정보
	private String name;
	private String myID;
	
	//스크랩 정보
	private String if_scraped;
	
	//임시
	private int pageStart =-1;
	private int pageSize =-1;
	

	//생성자
	public BoardVO() {
	}

	//게터&세터
	
	public int getBoardNo() {
		return boardNo;
	}


	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}


	public String getBoardType() {
		return boardType;
	}


	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}


	public String getUserID() {
		return userID;
	}


	public void setUserID(String userID) {
		this.userID = userID;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContents() {
		return contents;
	}


	public void setContents(String contents) {
		this.contents = contents;
	}


	public String getRegDate() {
		return regDate;
	}


	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}


	public int getReadCount() {
		return readCount;
	}


	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}


	public int getBoardAvailable() {
		return boardAvailable;
	}


	public void setBoardAvailable(int boardAvailable) {
		this.boardAvailable = boardAvailable;
	}


	public int getPageStart() {
		return pageStart;
	}


	public void setPageStart(int pageStart) {
		this.pageStart = pageStart;
	}


	public int getPageSize() {
		return pageSize;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getMyID() {
		return myID;
	}

	public void setMyID(String myID) {
		this.myID = myID;
	}

	public String getIf_scraped() {
		return if_scraped;
	}

	public void setIf_scraped(String if_scraped) {
		this.if_scraped = if_scraped;
	}


	

	
	

}