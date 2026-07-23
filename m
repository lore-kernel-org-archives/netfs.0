Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AE1F4181
	for <netfs@lists.linux.dev>; Thu, 23 Jul 2026 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791533; cv=fail; b=CzIn9a30sCruzHvhdK21rPAMVOXJ9Yb/6ovQfe3GzVf1xYjCa95Rt9zRi1dwdCDYma/B9m/i1g8gMR0QE9oNUt/5FYayquM96n5j1FtOBUbe8+EbK/AP0TazEPE0Fq8Y6wl0esQVPDTENfTX8YYrwPD/dNAoAGu3gAnS/yVcVeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791533; c=relaxed/simple;
	bh=cUcyWDJrqgtEAlQBUrRtTgKDaVsU4cGjvOIr5VEcNDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t+6R8+Np+N2XsWCzDZVAIJ14paBtNO+t3v3S6ppWoABoelg2yUa/JLh+n6N2cssvv1xSDp2OxVVaFychiLk5FVKg8ykUXlCeYQqxIu4uJEiyRo8fSg15vg5cETf0zU8tx+0v4j4iYL13hwEGKm0T352yM52izJce7sh7JEy7NQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=s1+89PwA; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="s1+89PwA"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N5MRbR2649259;
	Thu, 23 Jul 2026 00:25:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=hhdTCJLEnmDBmN1y4lpu9GJrcq07cZB1SbyuEHnKB28=; b=
	s1+89PwAEs1CCWGZOzLmUQ1KODbexurWxOrXddwKc7eXO1PkKDzGW4wzsCaGYzBo
	pqnX/aWqA5iuxgFzWt61n9x4QU4R80DHHgsghaIvA5LRNTI7EkWET4owN0agVBe6
	6TulLLGxAtIA8AdpS9TCDmIvkrmgynZZKMTbzgEHhhydiGBoK13puQ+5LVP7a3ex
	qWBkWeg6c5QQLNzPsWGce1m9qHCDso+ff7cLc4XrnNBhXfTIlS0+5u0CstTAIrrZ
	Fyz2bZndV/nTb1/FUsz27vSOScqezZDAwuseu7dpOeDGA0Nb5Jr7V1naDNyt3kPM
	WVOv+bSmeMwhz78tMz0PCw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fjt3u29rw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zISTFOxRj6BYX1lMPRmJmvihNV3eTazSxknrlRKXitECCxhoX17fJ/XWrrVmZvrDuBFG05jIL+6jOFilRUOx7On4KLlgVi2FEKwfNgfry2fmcno358dzDPPt/ScLqlpV4d8QT/ZE0JgYqi7sIcNC7T1JpBhccgoeKorPwvUt07o2nCtxGtuuI4T5NfBV87jIA23XSoL48WAEHeZZumtPobGEfY32v2VLGCOZY0RfIyNwvF1gRc5Mg8XhmJO9Sk1LpEjMCRWTGwFrGF8/5boMfGTmV7DxfhoZmJBXPH9tpB+KXVwS0RRiHH2Iio7GTFSog+SkTnPgRbygT793upG++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhdTCJLEnmDBmN1y4lpu9GJrcq07cZB1SbyuEHnKB28=;
 b=FOU+nbd77453B3bnGj2AMFOrcv5U+LIgj0O5CoDd+uM1VX9601Ebq2RHb13YgNq0/s/0aiYnLDaGl4Tz24Li+HF22W0+lRU2ET2AQ4qVSmrx/HyVjzPAIFNI8rKaUAv2Mm+nceRM7gsMhNH250wDxtWcixpyjdpTwjXqF5/VhFGlxyN0fbqo86PzeHUVJTGXKe1F5Ma/PBGpK9swXIJ/MXXYKmGrbbcQCNECMpQhuyJoyrdWaLIhW/8sgz4tdQjb+dRyM5SxCUZQFhNzeaS7xfm9FuvLBWEJDPLZI7j44NbhpsfrRa0WxNGUKgu8ZU1FBSGpnmP9pmFkl4nQNkefKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by SJ0PR11MB4992.namprd11.prod.outlook.com (2603:10b6:a03:2d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 07:25:14 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 07:25:13 +0000
Message-ID: <9fea3180-227b-4d85-9a60-16caee66be8d@windriver.com>
Date: Thu, 23 Jul 2026 15:25:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: fix ENOMEM handling in netfs_writepages() to drain
 all dirty folios
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260707052555.2055002-1-yun.zhou@windriver.com>
 <amGfmQHmZZuBkcwq@infradead.org>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <amGfmQHmZZuBkcwq@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0151.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::6) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|SJ0PR11MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: 618de52d-5c43-4695-5977-08dee88b8925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HsMEIrr+68mYGJQ7TIrG/wHBE5ixyHpMzpwiCp98Hx3xAzYVuUXnJ4Km4oq0A7GlMak41tqijLQE8XBQfm2SZsJIZrsBkWFTsAe/xzHgZkxp1QOz6tir9GtpXDPwoZOt2zHA/tEa6nN/u7d/xecRdL7g3Dh6PXItV5biY0dHDfg3yVqz7RgFV9a/r3ePrJ/Kw800X2Wc5XTBXbp6CpRQfjDDHvdA4iEwt/4QFwwjZqBIFSNUWF6dfMFNC8tprACwRkb65VTSSfFiY2NmCR4v5WK58Frx0Z540hNDalmPWkhBHEX/x1DbUDCAZJwSkBViz/s0EBF4qat855Xit6OYI0pGO1Gq0EX7saQouHp/y7HwHtD9RMc3ERtqW/sQwJzjPfSONVTXMGrI2Plmod3VpY+61n4JnYQ5U6umAXOkoNaz9hrkmVtC+xRRLXLg+JYfmARlBbEZS6ha81Xtax1fsf7GuyU5vpqmD1cHeByZUpXlpvrP1Ur9csMPC9GNXxTFPabuiVc3kEZtMgcREjIk+dINqZ+OzBqH3GxNQkEsVNcoGAxx/CVEEizkWhdoFJADmPUtwDZ74fJVypxClnYErJYl/ei5D/NUPcVhfoO9C/cWG6bhR/qZ62LCe7Gv0q58HjQh2+MFzTdns1WRPwgBFTdWKtAzcum8bYhLSCbPLc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eis2NkMwS1NNbmJtOE1DdUZBaHFQS1cwZTVjVDBvck5lMWdIZkdNMWErc3Js?=
 =?utf-8?B?MFlYODBkMCt3YlllUXpydkIyVW1sbmR3eG80NjhzZjBibXJwSkNwTk43bzI0?=
 =?utf-8?B?N0pOZ1VZc1c5ZE5sdkZWRmNiNDlFNEJQUHVjUnoxVWRhUlB2d1B0ZEVjYWxw?=
 =?utf-8?B?K0VzekJnWDVKa3pRWmkvSm9uejZ6Z3RITW5aZWF2ZGNJZUJmN1JQOUdOb3c5?=
 =?utf-8?B?K1hndTlHeWp1VjlGTlRyR2Q0TWVVV0xaRXRSVzlDOGpSNDRzQW1RdGQ4enk4?=
 =?utf-8?B?U0pPV0xLNTBHWUt0TFI2b1g1L0xWaWpHQncxcGNSZTVEQmxxU3NwSHNOV05h?=
 =?utf-8?B?dkRmQ3V4blg1ZE5TZGVzdUk3a2dUMTJEaFhEOUxGaHhXdjA2ZzFPMmtnNS9S?=
 =?utf-8?B?aG9kMWdyRmJxWUFKV1JySTJwL2ltS1JTYURYLzg3NE4zb2lnSWtkdzEwVmVh?=
 =?utf-8?B?SWRPNkJZUjZuTFRDdUZzRVZOMWd0RlRyNGZ2amo3ZjMwUXJpVGgvWUtRbnNX?=
 =?utf-8?B?UDV3QVdxWlVXVysxNDJxUnpia2grczVHMS8xZkFzeGI0dGR0SDA0TTJsT1I2?=
 =?utf-8?B?Vzk5WldWME1Hb29PeWhIOUF0Ymh2b0tqMU4ySG8raGFhWmkwWUtMUk5nd09p?=
 =?utf-8?B?ZWhublFEekpFSWJJMlc1TGZjRUYxcTlkbnFuS0VXcU5GNnI5a2Izd0lnZUVG?=
 =?utf-8?B?ckxrRzFxODhTZFlOQzJIUjRvaTZMcmsyaE51czlvajhUWnF0RUZNQ25pSVIw?=
 =?utf-8?B?WXU4QUFJeGxuZVNIS0VJYlN1M3A1dmU0V1lsM2dwL29mbW1vbTVBakpNcWor?=
 =?utf-8?B?TmJaSElBdmRMRU8vU0tFRmpSaitmdWNwU0p1ZEFCYUNuVEZxZEJFUVdhVFB2?=
 =?utf-8?B?MTZwS2VlbXNCcDJkdVpaVDlMOFdIVnN1RXNSSGxza0loWnR5ZHhhZ25udTFl?=
 =?utf-8?B?cm10NVpRSk5kVHA5YU1HUlZUVkg1QlpaNVFyMVBBRmpidVB1bjJib1ZLNGlF?=
 =?utf-8?B?MTRucHNCWm9xbXJYZ1ZRRzJUcnlaZlJUQy9Yc3dPUVZPZnk3SlFxa25pNmNX?=
 =?utf-8?B?cUVTVWkzT1dZTnVHTG1FTE1EQ0FNMGJSdzVRcGZ0Lzg1UzFacTc5US9DYkd1?=
 =?utf-8?B?cEI3emNCQzVBL1BwM2c5N09TSTFRNkU5aTBSOEx4R1RnM0EzaHNFZzhPRW9w?=
 =?utf-8?B?UFFSR3RUenBXZExsSWxRRldxU2pKc1c2RmI2SVhYMUkvZDNheXFiZ1JJbEhm?=
 =?utf-8?B?aEJJNWUzLzBPOW5OT1IzT002Z0x5S0xXeGpEZTQwVUoyTzRVMEp1aUMzV2hL?=
 =?utf-8?B?QXRwam9PUElXTEo0eDEwanNGK01wdDEveHVzSG1JeUJpTERQU21UNHUxNHRq?=
 =?utf-8?B?aGJHczhBb2FLR21xLytoSEhvQlFnZHpRU1VRV0xUZTZoWkRPOUhBSDFBZVZz?=
 =?utf-8?B?TWlyV1hFUlpXWlVJemtMNWVIS1ZUdVRjeWJYSUl1MWZ4bUdZV0g4NnY0MjY4?=
 =?utf-8?B?VTJMRExoVHA4d2k0RzJ1WUw5NXFmVXNyZnI5OGVvd1FURzBXM0xqYmNrejBI?=
 =?utf-8?B?VVRmM1hoZy9FcDRsb3VSYVV0cGlYcmd0Wk5YL0Nwb2dQeUp6UGdLcHlTR0dG?=
 =?utf-8?B?UEl4NTNOUnBtQkpXNFRtOXpEUGovdkFtc3ZUZkdTK1JSSXZWemdFQ3hMOWdH?=
 =?utf-8?B?Vk9JeVdKV0huTDhqbGc0eDloVm1kSUZSSTdCN0RUaGpJb0w5TXN1UDVDQjFN?=
 =?utf-8?B?NkZNekZ4TjYrOGpZL0pkRjVtdnEyeUdyZWZTY0xyVC9yS0Rlb1Rrb2dOWTRz?=
 =?utf-8?B?TmttRnpkZ0JwRmtxUEFwYUEzNElGMUdzUUFiNXRJRy84djFYWTFWUk5Zcnpj?=
 =?utf-8?B?MWltNFVaV21VeVE4MTdORWFZWmlraXU1UXE1Rk55OHYxMm1JY3BDUHhWZVN1?=
 =?utf-8?B?cjlXMVIxYmdmektiMzB0dzhySXEzd2NjUS9rbHNPaFgwcWc2S1ZmNjNtaVQr?=
 =?utf-8?B?cERPRnFvK2plYkplVXFyMmt4UE5mUXFlZ3RlUTY2QmRuWmwzZFIyUHVHelJl?=
 =?utf-8?B?MTNXMVFNY1g1NUk0S3pkYUN5VjZpTENGWnBMT3hDMlc4bkVaTW1CemNZYmtI?=
 =?utf-8?B?UFk4QjJ5QmMzOVhDWnZld20zV3VCSTFyTTVlMEFmWmREZjh2R3NoY2dlU3Ru?=
 =?utf-8?B?THNWODBWbm9rbmNaUFRjUEk5UXRhTy9HbWQzSU1PQ3ZOaGlLRndKYlVwNnA3?=
 =?utf-8?B?YzZUNXc4YXNTd056OE4xbFF5QTE1UVd1LzdnTlZHT1hDSW1TMmFINCtnSjdr?=
 =?utf-8?B?NzN0dzRjQ3ZHb0QvMkdXTWxoS3gyMjdaVTFKWnpIcmJFREY2M3VsZz09?=
X-Exchange-RoutingPolicyChecked:
	A/C4r7nCn/z/nEQags7RJFxZTnXchq/ZWzu7UOejD2x/l7U82eNziZO+voqjyF6J50WFQgcMe7CLpSeJ4aONrchQtt7RvYx9rjVcZGxPQF43W1nmUckQ+N99nHDOXMFDtYGt/y8rMMIMTGQ9OOmlE5yXijBSQ6PFq+cZaj/2NwnWEa46GfjxOM0APz9cBqS6XD2N8Dh6Jf7F3nCfCD2qTuGl3tPTZgn4d1TyG0lJO2Q608pWPwrMr0EB4cVsoCSowzEeMBeS3TAoWBnxOC8GOlpsRArQtsYcoWsTqM+neY6EAnJ4dJW4R5e0+oITng938wLpij6sGEqPMk4W91zy5A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618de52d-5c43-4695-5977-08dee88b8925
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 07:25:13.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04jaNcWbxj8ivT0HFxN1qqins3hqkf+D/mAuzUFCwkReHavbW+bcasX6uzxMTiHp9I4p43jBGAEaUMDIKi10MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4992
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA3MyBTYWx0ZWRfX0ECStQuPha6j
 8fIkqffeJk7mO1R5Y+r2mPo2G90y8HrW+FbWMsHmf9ZfZcewbI1PpbiqtqIbodAr6kb6fsWa1y+
 q9defWuJofrFSWnXtDfdEo99/i4XG+ev34nTINj9lLb319M1SZ5p6sb9/wfWUi0vbVLNVcn19aw
 QQcKgzt6m1yYB9a6vz6uGlYjeeSc5Vp1cHdKueV68woxGLTawqdmKt6zXyfJyDYBa5PeJYpzah8
 qjqbjeVRNm0q+SExYLaC5+Mf1p6DPGnoos4jfuE0hEE+nBDcwXGu2qcMqsy/O6ZbAhF2CT65HAb
 cRcydeb6SEnpbahPCEL/g8RF+u9tkvTlkKk4psR74T66HD1qsrruDdlPKpyC6eHY+rrkEgCK8H6
 D3naveDjNa0ijx9j97KUU6kTajqXgqeu+UL1JgXF2C7Yj5DteQLiQIOHTD8zUej2mrr8uT8QHcq
 DhzbfvXS8KzVfi0h4Hg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA3MyBTYWx0ZWRfX+8YRRXyMdWZU
 kaQjdFf3Z+UU0/e3MGHD9+PuWWBSnGjOR/hqyGT9cak0At4Ztub4XlottdxCzsbUxl8+NNAkn4F
 1ZfRTzrwxK4e1DsS2WFI+VEuQadjclGmY8kXD/Tsw8Bg2B/iuQaI
X-Proofpoint-GUID: rrVxK79actBxAV5CL_FJAMkxkcjfg0pq
X-Authority-Analysis: v=2.4 cv=U9yiy+ru c=1 sm=1 tr=0 ts=6a61c1dc cx=c_pps
 a=KcDtNT9Y7DbXMZTh6VQ3dg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=ItIgLucf9a_KYlnWXAYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rrVxK79actBxAV5CL_FJAMkxkcjfg0pq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230073

On 7/23/26 12:59, Christoph Hellwig wrote:
> On Tue, Jul 07, 2026 at 01:25:55PM +0800, Yun Zhou wrote:
>> When netfs_create_write_req() fails with -ENOMEM in netfs_writepages(),
>> the couldnt_start error path redirties and unlocks the first folio,
> 
> writeback must use mempools to back resoures, or __GFP_NOFAIL if it
> can't for some reason.  -ENOMEM must not happend in writeback paths
> or your toast.  So please fix the cause of this error and not the
> symptoms.
> 

Thanks for the review. You're right - writeback should not fail with ENOMEM.

I'll follow your suggestion and use __GFP_NOFAIL for the allocation in 
the writeback path. The ENOMEM here comes from rolling_buffer_init() 
which uses plain GFP_NOFS for its folio_queue allocation.

Using mempools would be the more robust approach, but it requires adding 
a new mempool, modifying the rolling_buffer_init() signature and all its 
callers, plus the init/destroy lifecycle - a much larger change. 
__GFP_NOFAIL is a minimal fix that achieves the same goal for the 
writeback path.

Will send v2 shortly.
