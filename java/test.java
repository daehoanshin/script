public void getChangeFileList(String filePath, String fileName, String user_id, String user_pw, StringBuilder listreturnMsg) {
		logger.info(">> getChangeFileList");
		try {

			// SCM Command 읽어서 split 배열 처리
			String splitWord1 = "                                    ";
			String splitWord2 = "\"path\": \"";

			// 경로
			String path = "";
			// 파일명(확장자포함)
			String data = "";
			String rootPath = properties.getProperty("ROOT_PATH");

			if (!("").equals(fileName)) {

				String[] fileNameList = fileName.split("[.]");
				// 파일명
				String fileNameSearch = "";

				// 파일명 추출
				if (fileNameList.length < 2) {
					fileNameSearch = fileNameList[fileNameList.length - 1];
				} else {
					fileNameSearch = fileNameList[fileNameList.length - 2];
				}
				logger.info("fileNameSearch : " + fileNameSearch);
				logger.info("listreturnMsg : " + listreturnMsg.toString());

				// Command 배열 추출
				String listArray[] = listreturnMsg.toString().split(splitWord1);

				for (int i = 0; i < listArray.length; i++) {
					// 파일명 포함한 리스트 추출
					if (listArray[i].contains(fileNameSearch)) {
						Map<String, Object> itemInfo = new HashMap<String, Object>();

						logger.info("listArray[" + i + "] : " + listArray[i]);
						String temp = listArray[i];
						// 파일 경로 추출
						path = temp.substring(9, temp.indexOf(fileNameSearch));
						// 파일 추출
						data = temp.substring(temp.lastIndexOf(fileNameSearch));
						data = data.substring(0, data.lastIndexOf("\","));
						// 파일경로 + 파일명
						path = path + data;
						FileListDataUtils.replacePath(path);
						logger.info("path : " + path);
						logger.info("data: " + data);

						itemInfo.put("data", data);
						itemInfo.put("path", path);

						// 파일리스트에 add
						searchfileList.add(itemInfo);
					}
				}

				return;
			}

		} catch (Exception e) {
			return;
		}
	}
