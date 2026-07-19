Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC2A1BF33
	for <netfs@lists.linux.dev>; Sun, 19 Jul 2026 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784464354; cv=fail; b=QRmw2aPSHhK1j0OmsG0nPuF6P9zRjzgKXDOV9L41E86gxAcX0MU3cdHqm432rgv/IgMNAms4GBJEPB8lL1TGMzau0bDROah/yQGWyFziSvxBdaacbqlyLP1AoyyyLUJCFvKN+RD7P/nJ4YqkRE/LRf/U845zoYJ7ncp3yvN6J54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784464354; c=relaxed/simple;
	bh=mxLd1/LFb1CQvgUiaB0LdAtHtg4sqnAlxaHo8oIj4Fk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sDwuq60ednv5maxldmqRhSIi1Zlt1XlkmYiSFi/w/yh5ZtFrq37wSFnNdvvnxRGi9Kbjt+eLfLMI7ub4d2qZTxM3qP0Ssb9laZBBwzV+9pEndNeyl1IUdGo8kBMagUXDPq1buR0pLdFVlnfLzDUnW/8f18bFv6IfhrPdwP45cjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=AijSXH0b; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="AijSXH0b"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JCTi1k1824485;
	Sun, 19 Jul 2026 05:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=QKBhqyvjDbw+yMfU4FHtxOunBMFsmP2mcCsb2ZvAsmo=; b=
	AijSXH0bCzKS6yyPDANgBoIwa4pVhoIFC4fM2vdH1oH0d4D33j7EsEhTnin4KbbK
	5AgsX7ClId8TVWNmk9pprlnj0kU0Z/LIydVrH+EToSu3qqfWx1YaqizxKAhRThiF
	qw2TR9fWXYKDRlTBFpsA+sKqSj/H8YvlUNPRb1AsRG0WQ8PevR8onSCd1ZC7Qlpo
	hN9A6pNagCkQIZK+dLoTMjlE2R5AnqV+sWn9YfFsozL1kqdjjJGXxOd3eXjsYHPI
	539rTceHxcbrmhiBYIdP6razdhQ8H+F9YzfImXKoIg8C4HAseMvNEPS3NO8Em1IN
	FM/cB2YZtS7S3jaqb35/3g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fg4rygy06-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 05:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVBCM/+a+5CPqH2I9fRlmBF/ZJrBjDxWEp801wguwpm+3oSNUJCBTYmWF/PEfkOCO9GUshVcBq0xklH+xy85ECsqJuBcIJ6wJ6E529TTQ3GlUmWf2TpYuLTlMOgeyfxiV6rrKMnffD77bvrSBJRIVAlSulgQJCRVs9pgr1h7QGxMXS5uHTxm2gfI61/xTO6at7ORM07qGaeHbFJjZ0aO8KsTFl3wYrHhhCz8EALWNh87pQ8ycN9vMczkcR52MVbR0aJjM2yoXJ4AOj5xJGk/cb+sKvxnBhgBuGH65KjlIaSvOVG51Vg3RqvqVNj2V0lZ3Qr2pbm+8ZASpAW/V0fsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKBhqyvjDbw+yMfU4FHtxOunBMFsmP2mcCsb2ZvAsmo=;
 b=GyUw6aswbMQ3fcrPMyMpuAJTPK+B13Pv9A4LvQjPiicxBBVKNcwfQrB8DdF8IVjgOC6VZmbdjjQTz2JYEVn0+CvPCoSW9/6owN1UkCtxFplWJ4xLwVJZgavgI2PBy+R7lOmh/nNsLEd5T5Ur1Vp3MHiR8IGHtRov8e0PY5amA2qd3Ax3k7YGfLnZvMpzNg68DDEVAOuxlzwvkLO7//Pw5g0t89obNh4FoSIOEChMm8MY94ZrZDHmJNG6qBsrzLCFP4JRfOAziFvUygoY+jWBKSGvJT+M665yBcgd0SbRh1r2yBkMeKpTYSxRpY5BHFmJN9J9lLxixWdOF2+N9Kkf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 12:32:28 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0223.015; Sun, 19 Jul 2026
 12:32:28 +0000
Message-ID: <6259a8bb-1164-4c65-9311-f2b2dc5d21e6@windriver.com>
Date: Sun, 19 Jul 2026 20:32:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: fix ENOMEM handling in netfs_writepages() to drain
 all dirty folios
To: dhowells@redhat.com, pc@manguebit.org
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yun.zhou@windriver.com
References: <20260707052555.2055002-1-yun.zhou@windriver.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260707052555.2055002-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0154.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::18) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: c32b91cb-f7cf-4699-cdb2-08dee591cb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	+4tFOuzd/vlZ98ehLcvSUQiEVFJT4dFu5tr+cjrCN3ZP4kYpaaNxdcuXBxRjZbVDw/0EZw7bHFkFKCU20omaiK+Ghx5nxkiifeuq7FuNm0DI0ehm5V0jSev+QHDgcj0cekpmIkmJtQK2YNbkvRqKgTox2aft0FlqL/sV5H/h/uz5IShczfqeaS6OsFY5C26YxDarkblr5wXUNaVPYczchD5vya0pVxIpHDXKES/lJbPzuLnLbvJHY+ePTZw3yIM9/OY4ZhpWBjykD6bmb8UrO9DSTWo3ZetbMn1xA8esTvttSGHFcoxkHuFJreRtek9qLJdeJGOhNzvT5BNQwMJ47BskOeqp5IKBeXtcZivkBexEYwo5qoj5xFLlyfPK7HxJazKR7R3KgUgK1FLqHXyRkzhJ3AH6rZZbz6TdjLXbJbV8yoUReP9vZf1zlAh4n8+BNlhGQZ3L1LMZGYMHA8oqUH1rZnXA61G+KswprDTaWZ/8n70gPBWKxD5770fAUd4gI4/vgo5/mpCusyJpIf/LQyFBpHnsQa7YOAvwQ0JglU+cDlGd5PRliZS5h6rm8TJPHOBiCeWR4QWcBKxxDy+0IN5YbqRdOkmezywK4D8z7yLT+5Va3WlmAWOk22N5j6Vq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2pHNGFTYmZXZW5ESGQyOVZQaklJVjhrOUUrQ09QNEdNdjg3WkQwa3pKQWE1?=
 =?utf-8?B?UExVL2hOaHpnV3JYanRqWGM3ZDRkS0VWaDBxUTV6d2hqdkN1M0g2ZlR6ejhp?=
 =?utf-8?B?YWtVL2tmTVVoUHlhTFoxYTM1TDlVQzlacHFMNE5jR2N3KzNpTGR2b2dwcUR3?=
 =?utf-8?B?MEtpc0hhWjlrU2V1WXFQenZ2Yk9MaEE3MUx6UmUzY0tJcDh6ek1CMXFZM241?=
 =?utf-8?B?VWdhR2hUbkJERlBjcDFDc1FLamFUc05nNkJGc1BCc1g0akFGTWpXUzBRNjYx?=
 =?utf-8?B?a1lBV0dlL2orNGRwbG81aitNK1c3UUFZeFhRV3RVcFgxZ3pPWDJFeDFId1Fk?=
 =?utf-8?B?ZVY1Nm1uVXEzSmVaL28yWkNqbHNOelRMbnZkT3U0MzRmcGV2OUl2elBBc0dB?=
 =?utf-8?B?ckdPbk8xY2d4UHRBbXJCam9KWkVTNXRwV1l5c3NITFBRZEl1M0J0aXUwQ2dL?=
 =?utf-8?B?M0dlZ1B1aStTMlNHZ3o0Um1NeTlGZTJYWlRkbFlud2FJdmxRL3FPK1pPZUVR?=
 =?utf-8?B?aStxNDRnaVJQSjUyS1RPSWxvZXpiMkFDeEtRUjloU3FseDQzVnpDeTR5VHRj?=
 =?utf-8?B?RGRJbGxpdmQyZzJ6dTFzdnZEWkdDQlpPcW40amZoWmdiUzVFQWo0L0Z3aFhY?=
 =?utf-8?B?MGd1UzYyNEFvVlBoZ3I5VFQ1UDRuVW9zU0lTaEdqanRnUnpFNFdLS0VpNlYv?=
 =?utf-8?B?Ymh1V2t0c3lTRkNwRmg4eUMwQlZURWhERkpoL0RwRW9qNm4xZXdhUXlFQTRE?=
 =?utf-8?B?aklRR1I5MWlUZGNjTDc1SWh6bWFyak5rUDNpWHpwQk5VZW1PK1NkVjBxSEdh?=
 =?utf-8?B?UFFzTGk0NGJ6VGNvRGRtS1FuUkd4bkVrd1Jyb2Y1dzhHNGZVR1VHazJqSTNE?=
 =?utf-8?B?UnltSERHaUlQaUptNDE0ZVZKNDlrbC9iRUFXNjd4QjJDNWlnZzI3SHlKb2dI?=
 =?utf-8?B?NnloVHlnMnpHUWUvN0NmQ3VnVnJ5NVhReFZOQXdmTnYySEkyUFMxZmFZZ2pL?=
 =?utf-8?B?SWxWV3FCZThzdHRZeTdRdTRkMlFTbE5pQkx2RkhOdXpHazc1MVp2VEFWZlZ6?=
 =?utf-8?B?VWZFeWNxYkk2WmR0Tm15QzN4V1lKbkh3RTZQbTM0anRUSEVNUG4rTkNiTTQz?=
 =?utf-8?B?UitzZXRzb3luL3dEWEFGdVB4RkRmaFhhSFBNN0FGbVhUcnNjTE42Zy9RTisv?=
 =?utf-8?B?S1JOa1NyNkxtTTVlTml2dkh4cTVDN044bGNzenhQdzlVZzhCRHYyOHFlVjVQ?=
 =?utf-8?B?QWRkSUtTRFUvYnB0K25zbHovcXBHZ21LWkNRMVR6eWNqbnJMZGNhWFNmSzdF?=
 =?utf-8?B?ZTRvZXFqbkUvUWxzVkVuMHJZNUpmS2g5ZDRhZEVIRWQ3YXpGTm93TzA4U2Ja?=
 =?utf-8?B?bkZkUk81bUlFaXJxdGdVRE9RaHVDSlg3Ym1iVDBwV29YbmpvMHgvT3lGYjE0?=
 =?utf-8?B?WXF3dFNMSExNcURwcU01RkZXbDNhVXM2TXVCMm9MNHgrS3dIbTRDenFIWFJV?=
 =?utf-8?B?a2R6MHN4Rm9VRkt6L2RUUysrY0c1eDRSNWZ0UFNBWXJ4a2NRdS9CU1lWQ0Jn?=
 =?utf-8?B?Ri9DVUI3MGdWSHFNclZJVmZjbmpnVkpWRVFsMTl1aTA1SzRvMi9wUzg5SHVh?=
 =?utf-8?B?RVRNam1IZkhEN3h2MWlXdHdmTHF1aVN6YStGVldNVzFFMUo0ZXY3RXp2d3Zs?=
 =?utf-8?B?c0ZHSllBeTR4RVNCOG52bW1taVl4NW1VL0UzSDBQVUIrTXpTN1RNUDhxTHdt?=
 =?utf-8?B?T3QvYUt2YzI0MWtHaGVyMGJDWG1ZalNQd0tWRkNQSkQ5Q05EMzJJc0F3bnVm?=
 =?utf-8?B?dzBES1IzbmZDVGJaYXlnZUpXb3ZBZk1uUm9URFpPNDc2Z1NLU29WYnNDQ1ll?=
 =?utf-8?B?Znd4U1Mra09iRzB5bU9SYjV5ZXFteFpBOS9SM1NjYmJQZTNLNWNpdEp5d2cw?=
 =?utf-8?B?T2lBVzBjeUxTdGV0d2ZCbE9mVWE1a1VQVnN2UVNIU1ROWDdGMklLRFJsbzNn?=
 =?utf-8?B?V1lQdUhLb2x6ZnJ1c0VnK1pJMXJNclZ0YnhDYWo0eGcraFBHOUE0bXViYWFY?=
 =?utf-8?B?aCtNSXdQQTFqTWlGNmxDbmdWN2lHRXl2dmFWUjBwZUVHaWxyMG9kUVI2M1E3?=
 =?utf-8?B?U3ZzNHdkUng1TXRxVXNxRjBwNjA1aUZiUy9nMnVJaGJPenNsbXRXdUsra0RR?=
 =?utf-8?B?T3ZubmdCUG1XMHdzWHhGRFN3cmxBM1hoKzMvVEx2Rk96VDZuL3IrTmpJK25S?=
 =?utf-8?B?TVdxeW5CRGUyd3k5c093RTQwRDFrVWdydTdjRThnRUpQakVxbUxzWS92ck4z?=
 =?utf-8?B?NHE5WFcrTHZjQk0wbUI1VHdJSnBXL285QTVOcUJvZFovNHBpSW5Ydz09?=
X-Exchange-RoutingPolicyChecked:
	A2fNJR1dhSQlcJ7KelByaeAQ5VWV7nTslvP3loPA/yoDjwA+IXymzn1mjj2sson49cpY8rARl77cIU4N2GtK35oCJYH7IafkcmzEoYm4JOFIx4qxAsB8i4+JBOkpZwHhaQdL1K1yCB0k1Ab+6L6PflEpHM8gUQUfMzvr3WMcuN95/Xm+BKLeUxvYxtlCPzfyoQA/s3EzkNCxe7KOftqjICLxCB/u0hrHvKgREZNcDqUN1UpNWU3sjWPSaN9PxihlwblUWiLxa6zw7qTHLvn6VZfpzgflVSGjXHPCYL7v1bOAxt3wvhmpEA/veF3xU4FueYewJFbJ6QJmFRCLVewWQw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32b91cb-f7cf-4699-cdb2-08dee591cb79
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 12:32:28.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKkGOSp/JJhHg/Q6W9RoYQxTN61KbyIDSNPYsco/kJfwh3IAb0oXPV+zTv+8HnxPeQjY8iA+Up/M8WiDzlaRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-Proofpoint-GUID: 1qqo7w5Sn-Goi7aexlRQtKzqnYGVx0Ml
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzNiBTYWx0ZWRfX1NFMHzvRQ9JT
 kf8L2Qn2DrG9iUIztb4TRO7Tbo54CBCdKlEfE7Qc8ayJEFY8JSV37IJjZr8QHUMVbBc8qOpnmTS
 rApSONOy7XFUHJuwNKl+l/DVwSj2x+cf9H0U3fJYMXnLygrc4StM
X-Proofpoint-ORIG-GUID: 1qqo7w5Sn-Goi7aexlRQtKzqnYGVx0Ml
X-Authority-Analysis: v=2.4 cv=CfQ4Irrl c=1 sm=1 tr=0 ts=6a5cc3dd cx=c_pps
 a=yMiMM/zaslgybVO5xx/4Yg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=7AAt-lWBfbXfrr7enPQA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzNiBTYWx0ZWRfX+llSVd88ayMW
 Bf5lLtkyNF+ksvxH+Tc9eiEJeShzXm0vMUIxC7Z7h8gI8rN7CKgCkKFyM/cr10zw4Lz8jc023FP
 c7uuqcgfMNAi6ewH9ShFET9Fq37wQMPW/ce3kEZDIbZiTtHuG8aZUV23efh3nYfmF0NVaG2via3
 70Wvx37NkL4BEI/TUX66mZFesY+FZByNcOZZ5Kwv2Ju5Mq7RPxEQwp+HD3AEnb+9QKCMcbkBHzI
 DlSj49WBu/Wd8ukYsfSqho0ZOgv8VI7jDti6k5C9f3+9UdYeoK/o7A+kncCHdLNcf3tvJuXBUDY
 SHQx8+9G6TPAUtGXJt0yX9WvfRL81VCXtyrYe9wNy1oy8EClJqTAoscyyca0vE7RgKc7rkMIlBD
 Weo6ku9FeIB1AujsiO+3JgPclKCBvmpjS1L1j9Fl7rG70qobWqux00SSwU5KrNp0DhNULwYdmgo
 0HO2gG+rkcyvyd64jvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190136

Friendly ping.

On 7/7/2026 1:25 PM, Yun Zhou wrote:
> When netfs_create_write_req() fails with -ENOMEM in netfs_writepages(),
> the couldnt_start error path redirties and unlocks the first folio, then
> calls writeback_iter() expecting it to return NULL. However, if the
> mapping contains multiple dirty folios, writeback_iter() returns the
> next one, triggering WARN_ON_ONCE(folio != NULL).
> 
> This can be reproduced via 9p (cache=loose) with shared mmap writes and
> fault injection (fail_nth), where v9fs_mmap_vm_close() triggers
> writeback on a mapping with multiple dirty folios during mmap overlap.
> 
> Fix this by looping over all remaining dirty folios in the ENOMEM path,
> redirtying and unlocking each one. This ensures all folios taken by the
> writeback iterator are properly released, and they will be retried on
> the next writeback cycle when memory is available.
> 
> Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0da43efa72f88bd3a8af
> Fixes: ac5f95ac5d6d ("netfs: Fix writeback error handling")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>   fs/netfs/write_issue.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> index f2761c99795a..5aa47128f7e7 100644
> --- a/fs/netfs/write_issue.c
> +++ b/fs/netfs/write_issue.c
> @@ -597,10 +597,11 @@ int netfs_writepages(struct address_space *mapping,
>   
>   couldnt_start:
>   	if (error == -ENOMEM) {
> -		folio_redirty_for_writepage(wbc, folio);
> -		folio_unlock(folio);
> -		folio = writeback_iter(mapping, wbc, folio, &error);
> -		WARN_ON_ONCE(folio != NULL);
> +		/* Redirty all dirty folios and let writeback retry later. */
> +		do {
> +			folio_redirty_for_writepage(wbc, folio);
> +			folio_unlock(folio);
> +		} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
>   	} else {
>   		netfs_kill_dirty_pages(mapping, wbc, folio);
>   	}

