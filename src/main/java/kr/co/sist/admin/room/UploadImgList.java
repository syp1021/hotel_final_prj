package kr.co.sist.admin.room;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.springframework.dao.DataAccessException;

/**
 * 객실추가/변경에서 - 이미지 추가에서 사용할 클래스
 * 
 * @author user
 */
/**
 * @author user
 *
 */
public class UploadImgList {

	/**
	 * temp 파일에 존재하는 이미지 목록 조회
	 * @return List<UploadImgVO>
	 */
	public List<UploadImgVO> searchImgList() {
		List<UploadImgVO> list = new ArrayList<UploadImgVO>();

		// 1. 파일 리스트를 가져올 파일 생성
		File temp = new File("/usr/local/www/hotel_prj/temp");

		// 2. 해당 폴더의 모든 파일, 디렉토리를 얻음
		File[] listFiles = null;
		
		if(temp.listFiles() != null) { // 널이 아닐때 !
			listFiles = temp.listFiles();
		
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a HH:mm:ss");

			UploadImgVO uliVO = null;
			for (File file : listFiles) {
				// 3. 파일에 대해서만 정보를 얻음
				if (file.isFile()) {
					// 4. list에 파일명 할당
					uliVO = new UploadImgVO();
					uliVO.setImgName(file.getName());
					uliVO.setImgLeng((int) ((file.length()) / 1024));
					uliVO.setLastModified(sdf.format(new Date(file.lastModified())));
					list.add(uliVO);
				} // end if
			} // end for

			// 등록순서대로 정렬
			Collections.sort(list, new CompareDateAsc());
		}//end if
		
		return list;
	}// searchImgList

	/**
	 * List<UploadImgVO>에서 등록순서대로 정렬하는 inner Class
	 * 
	 * @author user
	 */
	public class CompareDateAsc implements Comparator<UploadImgVO> {
		@Override
		public int compare(UploadImgVO o1, UploadImgVO o2) {
			return o1.getLastModified().compareTo(o2.getLastModified());
		}
	}// class

	/**
	 * 메인이미지 등록시 파일명을 mainImg로 변경하여 저장하는 method
	 * @param fileName
	 */
	public void markMainImg(String fileName) {

		File selectedImgPath = new File("/usr/local/www/hotel_prj/temp/" + fileName);
		File mainImgPath = new File("/usr/local/www/hotel_prj/temp/"
				+ fileName.substring(0, fileName.indexOf(".")) + "_main" + fileName.substring(fileName.indexOf(".")));

		File temp = new File("/usr/local/www/hotel_prj/temp");

		// 전체 파일 리스트 조회 후 main 포함되어있거나 같은 이름으로 저장되어있는 파일이 있다면 삭제 후 rename 처리
		File[] listFiles = temp.listFiles();
		
		for (File file : listFiles) {
			if (file.isFile() && file.getName().contains("_main")) {
				File delFile = new File(temp + "/" + file.getName());
				delFile.delete();
				break; 
			} // end if
		} // end for 

		selectedImgPath.renameTo(mainImgPath);
	}// markMainImg

	/**
	 * temp 폴더의 모든 이미지 삭제
	 */
	public void removeAllImg() {
		File temp = new File("/usr/local/www/hotel_prj/temp");

		if (temp.exists()) {
			File[] listFiles = temp.listFiles();
			if (listFiles.length != 0) {
				for (int i = 0; i < listFiles.length; i++) {
					System.gc();
					listFiles[i].delete();
				} // end for
			} // end if
		} // end if
	}// removeAllImg

	/**
	 * temp 폴더의 특정 이미지만 삭제
	 * @param fileName
	 */
	public void removeSelectedImg(String fileName) {

		File temp = new File("/usr/local/www/hotel_prj/temp");

		if (temp.exists()) {
			File[] listFiles = temp.listFiles();
			if (listFiles.length != 0) {
				for (int i = 0; i < listFiles.length; i++) {
					// 삭제하려는 파일과 동일한 이름이 있다면 삭제
					if (listFiles[i].getName().equals(fileName)) {
						File delImg = new File(temp + "/" + fileName);
						delImg.delete();
						break;
					} // end if
				} // end for
			} // end if
		} // end if
	}// removeSelectedImg

	
	/**
	 * 객실 추가/수정 시 기타 이미지가 있으면 파일명의 배열을 전달하는 method
	 * @return
	 */
	public String[] searchOtherImg() {
		List<UploadImgVO> list = searchImgList();
		// 조회된 list size 만큼 배열 생성
		String[] otherImgList = new String[list.size() - 1];

		int i = 0;
		for (UploadImgVO VO : list) {
			if (VO.getImgName().contains("main")) {// main img 제외하고 String[]에 담기
				continue;
			} // end if
			otherImgList[i] = VO.getImgName();
			i++;
		} // end for

		return otherImgList;
	}// searchOtherImg

	/**
	 * 객실추가 성공 시 temp에 있는 사진들을 roomImages폴더로 이동
	 * @throws IOException
	 */
	public void moveRoomImg() throws IOException {
		// 원 폴더
		File tempFolder = new File("/usr/local/www/hotel_prj/temp");
		// 복사할 폴더
		File imgFolder = new File("/usr/local/www/hotel_prj/roomImages");
		
		if(!tempFolder.exists()) {
			tempFolder.mkdirs();
		}
		if(!imgFolder.exists()) {
			imgFolder.mkdirs();
		}
		
		// 원 폴더의 파일수만큼 파일 배열 생성
		File[] fileList = tempFolder.listFiles();

		FileInputStream fis = null;
		FileOutputStream fos = null;

		try {
			for (File file : fileList) {
				File temp = new File(imgFolder.getAbsolutePath() + "/" + file.getName());

				fis = new FileInputStream(file);
				fos = new FileOutputStream(temp);

				byte[] data = new byte[512];
				int byteCnt = 0;
				while ((byteCnt = fis.read(data)) != -1) { // End Of File 체크
					fos.write(data, 0, byteCnt);
				} // end while
			} // end for
			fos.flush();
		} finally {
			if (fis != null) {
				fis.close();
			}
			if (fos != null) {
				fos.close();
			}
		} // finally
	}// moveRoomImg

	
	/**
	 * 객실 정보 수정 시,
	 * param과 일치하는 이미지들을 roomImages에서 찾아서 temp에 복사
	 * @throws IOException
	 */
	public void moveImgtoTemp(List<String> list) throws IOException {
		// 원 폴더
		File imgFolder = new File("/usr/local/www/hotel_prj/roomImages");
		// 복사할 폴더
		File tempFolder = new File("/usr/local/www/hotel_prj/temp");
		
		FileInputStream fis = null;
		FileOutputStream fos = null;

		try {
			for (int i = 0; i < list.size() ; i++) { // param으로 받은 이미지의 수만큼 반복
				File dbImg = new File(imgFolder.getAbsolutePath() + "/" + list.get(i));
				File temp = new File(tempFolder.getAbsolutePath() + "/" + list.get(i));

				fis = new FileInputStream(dbImg);
				fos = new FileOutputStream(temp);

				byte[] data = new byte[512];
				int byteCnt = 0;
				while ((byteCnt = fis.read(data)) != -1) { // End Of File 체크
					fos.write(data, 0, byteCnt);
				} // end while
			} // end for
			fos.flush();
		} finally {
			if (fis != null) {
				fis.close();
			}
			if (fos != null) {
				fos.close();
			}
		} // finally
	}// moveImgtoTemp

	
	/**
	 * 객실 수정 완료 후 삭제된 roomImages의 파일 삭제 
	 * @param imgList 기존 이미지 List (main, other)
	 * @param 업데이트된 new mainImg
	 * @param rName 변경 대상 RoomName
	 * @throws DataAccessException 
	 */
	public void removeOriginalImg(String[] imgList, String newMainImg, String rName) throws DataAccessException {
		//roomImages에서 지울 이미지 리스트
		List<String> delImgList = new ArrayList<String>();
		File original = new File("/usr/local/www/hotel_prj/roomImages");
		
		RoomSelect rs = new RoomSelect();
		//수정 완료 후 기타 이미지
		List<OtherImgVO> dbList = rs.selectOtherImg(rName);
		
		//수정 완료 후 새로운 이미지 리스트 세팅
		List<String> newImgList = new ArrayList<String>();
		newImgList.add(newMainImg);
		if(dbList.size()!=0) {
			for(OtherImgVO VO : dbList) {
				newImgList.add(VO.getImgSrc());
			}//end for
		}// end if
		
		for(String oldImg : imgList) {
			for(String newImg : newImgList) {
				if (newImg.equals(oldImg)) {
					break;
				}//end if
				delImgList.add(oldImg);
			}//end for
		}//end for
		
		//지울 리스트가 없으면 return
		if(delImgList.size()==0) {
			return;
		}//end if
		
		for(String imgSrc : delImgList) {
				File delImg = new File(original + "/" + imgSrc);
				delImg.delete();
			}//end for
		
	}// removeOriginalImg
	
}// class