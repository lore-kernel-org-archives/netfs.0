Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84F388363
	for <netfs@lists.linux.dev>; Tue,  7 Jul 2026 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404814; cv=fail; b=SQLfgXzBeCGLUuYFxZj+pCI5P7XkJhzRvumjjA/qZfuQSJ1tkzleXxFn6Kqw3feQ0MWtlixIiugne6KGWWIuEup70eGm5wnqrBWhGCg91ewdLQcPfTK6rUNyeTqksOUgkxSWvw9P3Gr7v0zr5S6jyCDuvcOvo3cbnXRN7qZBIDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404814; c=relaxed/simple;
	bh=wlV+JU8GgYB8h0bUA9YO7NIJAtms+n7yYcYCGkdTJF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ChU91LO0iWfURkEKH7DlWM3Jq4lwXYbQN5wbb4Wp1KZbjTaQhXYaFOlsvcxuKzlmSDFgh4dtVmppFIwmm6XF86lrRyXOu8m0XhiczSCWmUT6p8S8/z+f/OH80Z4665atfTMqC2xBoB7uHLTY86jIwjqejwYI4sdLgBgwaV6kEjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=EvhvIAqg; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="EvhvIAqg"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6675029N713033;
	Mon, 6 Jul 2026 23:13:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=idQD0DS8m+BSHZ9IsidJka/dTQQIpa0v0lh+Nq0E1bk=; b=
	EvhvIAqghzMOhQQvllF+398UxK7f7CWWlM3g803syhisdePeXVwVo46NTdTOLD4M
	zjmFxiGbgNhCqviTkZrlX2gbT2ekxfZH4bkLpq5XXuKgYyKz4y0vZpA2U3WNiJ+G
	b+VEXYaImqWedwmKpNu61VvoolIQgAllhK3UT0+nJNDPXMWh4TR8RhXiEnaVsdP3
	K3ZtFcTanH+4hPM1hWL8KJ7r7pIdim2LKNMd5mjXodaKZUdhnHD2kHWFKCuF/2yf
	Cb7mYCtOn/Hf36Gp07pFbJbRMV1MqBskF55t2QGFdvMTkoRm/Z7IOSS054kmIUcU
	FQb+Yv3kwV4ZTIqZLe39nA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f6wf1bedt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 23:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S60xR6837cPc3vI0z5yc0ImNNzR1B1xeyKlotdRkUDuovlolX8XNPTSfv3WOHhBOLVYvROQ6N4o0myGjC7v85LWcJySzM/xb1zjJ7sFxFJ8rVthigNywYWKtjZucaRGrqCIF7Edlp28V7XjhDkUNLUq7cDwdm11a+wuu1hXmzGnAUyLXxviQtAIkmAABG4ZTYlBy9RjZr9bNluN/E2gDjyDqPwqd1WQFibDwQowJn+KjmAkQ5nRnXnxhSTnozhAJ6EvpMGgCX2yAhG4Nr5ZwuyJQ3og8sfdKOwwpsxHg/CUWl6H+3Kq2fN1M+87i7T3T1hvdnf8d5WWUzSusoigENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idQD0DS8m+BSHZ9IsidJka/dTQQIpa0v0lh+Nq0E1bk=;
 b=qBU8NQpbpYf2kn47j6ZAESK5s4/VkW8WVRkhXC6uq5LimKWVstpyIFfEFpFzxx1ZL7UqSBv/fX0ors6+kW6qgHl+Aw3PSG4dIYRF82S2bIdtIZaQo3g6+4VQs2cISv6GE7h/rZnY/F4mfRkqt+fJwacDIPtCDCBuiTo+K/DpfvRLMQ+si49gjLndVtRL8r6psgF1982kr7iDyL/wSoGSEC3hQRW5dyVX6RLeU+mh4/JglWa1e1XlnnMiW3i3BtiI1h7RQtvNjz+GNpF0bHscNvf9GGcSwM1LAZZ5IsOXksxKkCbJfQX+W6zCSR7nlHRYgh7OeEHCJpnH2ydZW9myGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by SN7PR11MB7996.namprd11.prod.outlook.com (2603:10b6:806:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:13:28 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 06:13:28 +0000
Message-ID: <35cc1be8-e4b8-48a7-ae80-a95e9b1bef0c@windriver.com>
Date: Tue, 7 Jul 2026 14:13:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: fix ENOMEM handling in netfs_writepages() to drain
 all dirty folios
To: dhowells@redhat.com, pc@manguebit.org
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260707052555.2055002-1-yun.zhou@windriver.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260707052555.2055002-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::17) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|SN7PR11MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: c064a52f-08ca-4797-01f4-08dedbeedc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UwEFV2RmR+1F6Py25oHrQ77SOIK9FtVHHi9RMex3dii1Ud6coGJs3uHpi3BeNAFtFcXE3YTGzDAoxctILtvU/XRL8WryEROyye6hZZbhnDvEYavK2rpVmwXocXhQHjJKlpJQ47BYw9ffKge89+FYIL0SgnPITwgIBz7+wx/9e4/J3E/xNWVBUoXlxBln/bIVxP3bZ9Ntol6FjlwDkuoN/X6hLSTldtL/DNlT/vZb9c3tI6u9V8YAkoA7kRLZCNtOUZcKDJPFS/DSj6jMW7FQyV92bV+MrOkXxeJyWOxudVDnYLhh6jjbXvIfhdkgexs7pk7APLV7dwwn2tYb45KUnhlttufYq58VgxmG4FhF79H0ymOu70o4Ra5AWcBe6zX4n/DboBu9qHsykuXzyuMtPeLoTsqQW84zvRbR6iQ2u2qR30hh18de4VJt76OM/cvWQC4GIK5kLc+MDppOUuEDDQtAVvTjy54Kq7pmRoUhzw8t4DJNTsGHcgk/E6HI5ada1calH9t4r27AWLhVHURagxztXXAsEmXqjlaBfGaCTMLVC5HH1MYrT9tsZQwrzpWdca/ZRVQaBxnReweHSHYAWVHxYovltJxpqgTpp/erBmJRqauk3XByKMQx7acqXo3D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnQvTzZoYTJCU0J4Qlh3QXdkaDJtM3VtdXhZcEVIZ1YwUGFvWDBKVktZLy9s?=
 =?utf-8?B?UWFZQVlGVHZDS0VMTU95dGtLYy9KRkdGT2wraE5uMklqVmQ2dnFuMWNnS3d4?=
 =?utf-8?B?NlgyZjN4VUtVdm9Nc0xtM3VyaTd2djc4NEtnWGpXaDlHR0MrRklhMU04OGxV?=
 =?utf-8?B?OEVsVEwwNjNkOG9Ib0pwb2gxaHBiNWFhdlBLOFkrT3FSVGpRM1FLbnQzVy9M?=
 =?utf-8?B?RWx2clhhaExrV3VXUnY4cnhkNSt2TzI5c09PZEVkajFXaUlwOGtTVksycDAz?=
 =?utf-8?B?czJxbUpkOXg2Y29Ddm1QTnJTdjhjS3RWUTVPdURHckhuL0hsQmNadW5mMDh3?=
 =?utf-8?B?TXF2emp0QnQ4V3RXUERoYTR3cHlLdk9CNkpibmxVa3NXRUMvbUVLeFpTVkdm?=
 =?utf-8?B?c29yYUtBT1FEWFp3RnZEbUtqNTA0OWJxQ0t2YTVrZ3hJck5SQTUwNXhaUnhN?=
 =?utf-8?B?QmNqLzIxYjJ0dTgraVNNT09kVlQwa2pCMUVoemdNWXZVcHlWdUZPZSsvYVNr?=
 =?utf-8?B?Z0VmYm5ua05hdDF1MWcyRU1FVmU1aDFiakV1THBhUmtQeXoyeDZ2TnpOSDhH?=
 =?utf-8?B?QTk5Y21KV1E3amkvN1NOVGF4RUhMVU0yUjJDUWN1QkUzVEVSRy81djljU1R0?=
 =?utf-8?B?TU9VVVVWNTViNEpGRUJTcHNXaW5oNXROK041ZjVHTzJrZEVXejZaUWkwWWVJ?=
 =?utf-8?B?dmwrR2Y3Vll2Mithd21walFnNmRiRUwyU2o2MEFGVDdxeXVkM3ViOXR2RGU5?=
 =?utf-8?B?L05TZXpZVWVQU1diQkxuUWg3K2RXdGZZUnFGYVlKenorZzFrc2x1cklKYlo1?=
 =?utf-8?B?RWhMT3JTSHArZXFUWWFlcGtHcThOc2ZZaUdGVmFNOG9DVitBZS82S1ZVS0Nl?=
 =?utf-8?B?dTdjV05qTG9CeGpVRUJMbFNEc2c0MWZHQTRUaTh2b0gvMit4RFYwV09QRGE1?=
 =?utf-8?B?QmlsNURVTzh4OG1QZWlIQmRTTG96N1ZreG1iZnNBTFp2RFZ6TVVWV1IycXB0?=
 =?utf-8?B?ajQzQnRSc1RUdDBLdVdES0hqRE5RQnY4enhRTGh3OEYyWFV6Y0o1OXN1NU5r?=
 =?utf-8?B?a2p0WUJrTFJWcWwrVE9laEpRWEFrekFZYUZFd2hwL2k1em1wL0RJUzhTMHY2?=
 =?utf-8?B?ZzBvTXc3MWNIY3dkcXhSUFE5UE5XeW5BZUJwNVhqbk9ZS1hyRklCaGR2S3NZ?=
 =?utf-8?B?d3RmcVpmWlVBMjNWVTFBL2cvVm1rQ0RzNWNZRzIyQVVwUTQyL2U1Z1Q1cTBH?=
 =?utf-8?B?TkZmQU16K1JRcHo1OElCQWFpUVlpdEVKeDZQL3IzWTRvWmtFSWpOclM4Skpz?=
 =?utf-8?B?M1JxdWF0Q0xlM1VpQ2pkODJ3MVlWakdET2Y5UjNoaTM3dlhiVlRRMmdKaU9a?=
 =?utf-8?B?SFBrMjd5dmF5YTUyUWUyNjMwcDRLRlhDaG50RGYzRVlod1FMZXIrYzY5UTBE?=
 =?utf-8?B?V3c4TDg0MGJyc21vWlhFQ2VMd290UTh2NFhSeE5oaW1URDhZN1hvZnVWZFMw?=
 =?utf-8?B?MkthTjV4SEd6THkwUzhBanZTUEUyb1FBSkttVE9FSDVnQUlUc3NmN2xTVDFm?=
 =?utf-8?B?QlhSd0cva1lMcXVDTmRTcDZCeVRCdGhOWVpjNnBpbjdNL1dpdzBMV3FXL2wv?=
 =?utf-8?B?TEorVE03aWQ4dkRCYlpVTDlIM0V1WThrWnZzL05PcUU5S282UnY1SXc1Ni9Y?=
 =?utf-8?B?c3NBL3ZvTnFXUGo4QjViT0Q4MmVJVDhxaTNJeE9aTlA4N09zYnZqS3ZWaWxT?=
 =?utf-8?B?OWVUKzVFa2NjVzBBR0U0bE5XYmdIZHRaWEVRUkVEaEpzL0ExdnU2YXVSWW5S?=
 =?utf-8?B?blI2bHhvS0NxeG9XMld5S2NyWUJxK0hWc1Y2MXowMzZVZjErY3crSG92TmM2?=
 =?utf-8?B?V1plWHVVbTBDcjIyVmpBWVNLd2VQSkJtdGRWQWN2dTk0Zm5mQnpTaWFmM0hu?=
 =?utf-8?B?Z0dWQWFqc0g2NmRvYzB0SktUenRucEZBZVdTdjhMSXFFMzRiblMybUxPTSs2?=
 =?utf-8?B?WWFpd0ZFVG43a1l6cWFHekhYU3RxQnVnZVZjb1dQdnFrTHJGZ2x0aUFoaVRT?=
 =?utf-8?B?cWREV0dhVWFWQUNOdUhjeUl1ZzdGa0F0SElhdWJLTi9BZUtObnZBSldjOXRy?=
 =?utf-8?B?Y1RwRUZTWWZSS0Q4Zmlua2VMR3NzeVNWWU01YVFsQ3VXSUhNNlpTR2k3SGR1?=
 =?utf-8?B?OTRoNWhIbndic0M5TFhxYTE3WVVYdEV5UTNxdm16UXlkR3dGekxyYWJBOXkr?=
 =?utf-8?B?YTZOZ29mUFRQSjZOdzluU01XK2FqZ3kwck1QLzJaMzhDaitCWFFBNmFvb3ly?=
 =?utf-8?B?MFpoSUlFV2V6Q0xLbEc4UC9DZmw1U1FyYXFRYUJIbUlBVy85WXZ2Zz09?=
X-Exchange-RoutingPolicyChecked:
	TPU6+lBoEDaeqZDrnolHEh18OB5qmwE6YdksPv+7kb1SzbMQy6CsRQkvfExkPGgNAC5sHek5AtE95sTpWp+JDPgdMpnnrYqrpVdtuEwQk7v7dOScXXTeTsM3bunESe4Gx3sqQYFfJlKrbaKcUD9yhk/UTDhVb94K1CXDvBQwwMaVV8SqU0IPIuCE8Kp4zv7NmnEV6+tCvy26zPiSMtHwix2CbwuuN2zm05RTp7vh/S8Mp94MDo5GzXWPNIzkNAwm1YQn2mGyFWJ7Z3Q/w9BwhZDAvl2j+5NR0GBmajX68MlUjZ7O/uF/z6kmDFpu3edDEq2LVwybTOUIWIcBiaXTQA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c064a52f-08ca-4797-01f4-08dedbeedc7d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:13:28.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMLEBo6wgXMLKP3yErsRT0+X78fw8yJIAfLdaPNmGAx1XTs+WpmAGuGubluHrcScwV10nd3y7hgQgjPO8DNfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7996
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfXzhIZ9q+r/MQ1
 Ph0fxJDYLHtJ23a+OHbNm+w8dHAZvbDh5GqvGKR2H6R1uv2DHW1MTohpKWlt1Wqt8R0Pr9n4E0N
 bLYDts6QahyhpMF5NgOe9TT8WxwIBgJSWIQ0ytX5tzUGSvhJYbxcFiBJWEi7OQ7YGZCbebAo9Qp
 0C6DFhrO73NbL6F2y+ADFZaAhSmXE7zmsoDycwLCEtJb2AeJiuN4wHHzx/TBSR8JVEM1iqrhyFp
 hvEEX+5ehYwCLUU4puRFALYFWRBKePqspby23toL9JhSPDta69z13cYZPBBQmmiz3rV57EjqMSe
 K3MRnxuK579v4b3RWtqNVqYCLmkMthHIthreJd5yg/VzVFRHDjSSwPeQv5pUlgBAIgBaNAxZA+i
 9PQkalRTbPsjjUKIqBDj0nz3d3OUfT0AZ5ZNSdu7NBZz7nX6Kiw9QoA/IT4Vf66gF2h+zuxKNLV
 F45J2CKXaSHQdAgdruA==
X-Proofpoint-ORIG-GUID: OSznqhw65W_xMG-Ic1jFZhniBt6LS_wf
X-Proofpoint-GUID: OSznqhw65W_xMG-Ic1jFZhniBt6LS_wf
X-Authority-Analysis: v=2.4 cv=cuarVV4i c=1 sm=1 tr=0 ts=6a4c990c cx=c_pps
 a=St7v3kIWLLX4ycmTPR678g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=t7CeM3EgAAAA:8 a=420wW6rJ3FzkQzALq4AA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX85Bq8k2uC1ky
 ayI6bYWWhKcsnD42RD2rCfdacSGkZrKHdYS36FbRpi5pGVeLOvYLSjyXtYgs9WRWDgoANH07hQr
 g09YGdcUXcG4f04YNpi/Ii6NiIrZUrTbCQVXETmahQ+ynJMNIKLN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070056

Tested-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com

https://lore.kernel.org/all/6a4c9787.a1ad617e.25832.0006.GAE@google.com/

On 7/7/26 13:25, Yun Zhou wrote:
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

