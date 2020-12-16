package board;

public class ScrapVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String boardNo, scraperID, regDate;
	
	//임시
	private int pageStart =-1;
	private int pageSize =-1;
	
	//생성자
	public ScrapVO() {
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}

	public String getScraperID() {
		return scraperID;
	}

	public void setScraperID(String scraperID) {
		this.scraperID = scraperID;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
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



}
