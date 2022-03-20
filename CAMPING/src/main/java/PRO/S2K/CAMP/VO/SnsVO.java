package PRO.S2K.CAMP.VO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 CREATE TABLE `sns_member` (
  `mb_idx` int(11) NOT NULL,
  `sns_id` varchar(255) NOT NULL,
  `sns_type` varchar(10)  NULL,
  `sns_name` varchar(255)  NULL,
  `sns_profile` varchar(255)  NULL,
  `sns_connect_date` datetime  NULL,
  CONSTRAINT `mb_idx` FOREIGN KEY (`mb_idx`) REFERENCES `camp_member` (`mb_idx`)
);
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SnsVO {
	private int mb_idx;
	private String sns_id;
	private String sns_type;
	private String sns_name;
	private String sns_profile;
	private String sns_connect_date;
}
