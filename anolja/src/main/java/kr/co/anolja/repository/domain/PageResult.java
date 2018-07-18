package kr.co.anolja.repository.domain;

public class PageResult {
	private int listSize = 10;
	private int tabSize = 3;
	private int pageNo;
	private int count;
	private int lastPage;
	private int beginPage;
	private int endPage;
	
	
	private boolean prev;
	private boolean next;
	public PageResult(int pageNo,int count) {
		this.count = count;
		this.pageNo = pageNo;
		init();
	}
	
	public void init() {
		
		lastPage = (int)Math.ceil(count / (double)listSize);
		
		int currTab = (pageNo -1) / tabSize + 1;
		beginPage = (currTab - 1) * tabSize + 1;
		endPage = (currTab * tabSize < lastPage) ? currTab * tabSize : lastPage;
		prev = beginPage != 1;
		next = endPage != lastPage;
		
	}
	
	public int getListSize() {
		return listSize;
	}
	public void setListSize(int listSize) {
		this.listSize = listSize;
	}
	public int getTabSize() {
		return tabSize;
	}
	public void setTabSize(int tabSize) {
		this.tabSize = tabSize;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getBeginPage() {
		return beginPage;
	}
	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}
	
	
}
