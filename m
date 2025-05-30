Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021089.outbound.protection.outlook.com [40.107.167.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B113A244
	for <netfs@lists.linux.dev>; Fri, 30 May 2025 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748595816; cv=fail; b=QdRQYuv8QmXTaYDqlEq43UKmzymxZ9ClJCdS0SCVb8OZbRhvg62wWDqyYUKyftVa0yZnA5E9W4ooi42+8AkWN9BuiUEPaIb7ojzlHkP0iroVOE9ZQKS5lr1Wn881zQsPF3V6qs/a+uJ5+66COcBD2ojDQWjZsNMGbkjpk+3BXQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748595816; c=relaxed/simple;
	bh=3+1ynoJ5e+J3G83fjYrGqkk7I8MOG7aQAW5peiFQ28g=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=V15eLOCBOiyRmh4AvpxL9Jxsobp4zA1EhqVCjHJhACeIVPjPzqnOPN5/Acx1dEGiNJkdOcWxRq/+ym893LkTI6vJw7flaxAwNW0uo7U9+nR3yO4FlSnKmMyy6LeFkgWppbRiJ52tbs2AOWpI+i3E9TSGyvoOx1FkJIe19whaY/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=JNjSP7LL; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=JNjSP7LL; arc=fail smtp.client-ip=40.107.167.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="JNjSP7LL";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="JNjSP7LL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANU5ZP6NtxrOON2tbRaxERXbdepZbiGsJaNEhHJvAliIaFYKh3gRxc3LBb4Dr9zhLtOX+tWvUqa7B2vu42bPA8ppW0x2f6BXoFENHFkxTRpMGGzg28L1ilSsNXRfyFQJmitJoNQTUSiqaXoISWXz5OJEDuHQe5NfZuqx/SU0CvDYEBb0R5AE7BLcjszVa0gcXmft26rnl2X6YPrP+2QXqjy3k9TAKLlbGjvFXl1a3cWaQQz0P0WJEwsbMAgkJuV9DTH1ymPjOu6pNXFY5BlhiaRhw+Wduv4BuRzZJkLJldRGIWdjw5NZRcbXf5kmBFV//QRleDqEI1FYG4JW7p8WrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMNtPIGV9tFdzZOybSQjj6fInQM/yEsBVnBSX1tnUgU=;
 b=ObFmvs3KXhY3B7DrDiPoBZuKDYlDlmUFHrY33Cr2+nnMjpykebMVODCkVfqGPEd6ZQI7DGajkjrn06mWyfJ8Imp4GxzC2GZ8HtDGQr5G5LFbF4Fe7kCNIkeu7ZGQtyL4QvPdc6evhnKlS/KlXsb1w+jvpB7k8QPGeQy7/GxFW+Kz8X4LX/rcUtMB3/P0L4QCLjxaoaikcJ7/id3dpc3e3COW+LFXiQ7hiegPyiuHZdkVdjqGT/bIQtSUMNth/YMyiZRBJdi61YB0pC/IJnqKkuoBfeefmk2Ae2t6MlSRLFEDJFbHiCu+97Nw4zV0rgNUNsBdFcfwQGdlnpEn6bdFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMNtPIGV9tFdzZOybSQjj6fInQM/yEsBVnBSX1tnUgU=;
 b=JNjSP7LLdoKm8DFxhjJv3mxDOpILr/Zb4Fjl1YKQLAxS0ja3uf8NBjULp2SquI3HQauWQ4yVk8AKjqP6qmCTkmRM7M5jalNJhabWp9MRvvc30xKYymRC4quRl7i8Bz3GZED0Wh3zaxX/kzXNH2JsnhFF3fs9+NhhWEGvaGC3KIY=
Received: from AM0PR04CA0086.eurprd04.prod.outlook.com (2603:10a6:208:be::27)
 by GV0P278MB0066.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.23; Fri, 30 May
 2025 09:03:29 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:208:be:cafe::a5) by AM0PR04CA0086.outlook.office365.com
 (2603:10a6:208:be::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Fri,
 30 May 2025 09:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8813.0 via
 Frontend Transport; Fri, 30 May 2025 09:03:29 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=JNjSP7LL
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011027.outbound.protection.outlook.com [40.93.85.27])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id BDE5C814AC;
	Fri, 30 May 2025 11:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMNtPIGV9tFdzZOybSQjj6fInQM/yEsBVnBSX1tnUgU=;
 b=JNjSP7LLdoKm8DFxhjJv3mxDOpILr/Zb4Fjl1YKQLAxS0ja3uf8NBjULp2SquI3HQauWQ4yVk8AKjqP6qmCTkmRM7M5jalNJhabWp9MRvvc30xKYymRC4quRl7i8Bz3GZED0Wh3zaxX/kzXNH2JsnhFF3fs9+NhhWEGvaGC3KIY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::5) by
 GV0P278MB0017.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.23; Fri, 30 May 2025 09:03:28 +0000
Received: from GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2ca8:318d:37c1:fcd]) by GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2ca8:318d:37c1:fcd%3]) with mapi id 15.20.8792.021; Fri, 30 May 2025
 09:03:27 +0000
Message-ID: <31cd8f34-1b37-4062-925a-baedec8f2f79@cern.ch>
Date: Fri, 30 May 2025 11:03:27 +0200
User-Agent: Mozilla Thunderbird
From: Benjamin Fischer <benjamin.fischer@cern.ch>
Content-Language: en-US, de-DE
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Subject: Cachefiles slowdown caused by SEEK_HOLE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:54::5)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV0P278MB0805:EE_|GV0P278MB0017:EE_|AM4PEPF00025F96:EE_|GV0P278MB0066:EE_
X-MS-Office365-Filtering-Correlation-Id: fe581962-16c0-4a5b-340e-08dd9f58d87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UDl3WFY2U3l4TTRRMmE3M29HcFJnYUxQS296NjgrNTJEQnA1cXBRRGNHdFlY?=
 =?utf-8?B?bFFLMGZFWHhSU0p5UlVZOS9xcnVYc0tBVjR3RW1pM3Y1Um80cGpOS0pyTUlY?=
 =?utf-8?B?NW9JSDQ0UUc1Qm9vQXN3QnRtU29nNHFoenpJUVlhR1Fyb05hODIrbEJadnZW?=
 =?utf-8?B?c1NLeWU1Ykp6OWptRjBNWXd4SnZRUTRlMDVqNlhuYnJnSmRSdElDTTRLYlda?=
 =?utf-8?B?SjVKaGRrSGxpbExjWTNOUnc2VFF5OWUwMGp4aC9CM2YydkwxdEs0dlVsWkZB?=
 =?utf-8?B?SUtOcjY3ajN3Y1JLdE5QbTMwUEpIaUFMRjdnUFVVUUVRcUwwd3V4NjZNYzBK?=
 =?utf-8?B?OU9oTkloMnhMcWxrYjVWMS9YUDNVNTFxSktRSU9wclV0djBnYjFPVitsZWIx?=
 =?utf-8?B?ZkFIZWhhMG1oT3RTR0N4bXgyNlJpRjFYMEdlYzBmMy9uUWpxMVRYK010OXNo?=
 =?utf-8?B?Z0t6bEdrYjhkZjhlWnpia3lqSDNleGlpL1g1djFOT3FRRm41MVRQdTJvd3Np?=
 =?utf-8?B?NUJ6bjdwNS82T2xlT2I4VXFJZVlMM2szei9POHJ2V05tNmR1bVIzRXp0SjJY?=
 =?utf-8?B?ek1oN1ZCa3RQWmJDaHZGeU9WV2lRWFJZMWJKU0lPTFVJcTB6K21EZU5TbEdj?=
 =?utf-8?B?SU15NGFLYmdqSXFNNzF0ZGVNTlBQaTJGend4bXBwbC96eUZXenFrVzJEVmgw?=
 =?utf-8?B?QzQvc1JzajNqOHA0STVKb2NRdXV6d2RUQ3ZqWDM4NWRFN3dBaGgyZzZSbi9G?=
 =?utf-8?B?a3d2NDg5QXltWHJYS0NTdWJQVWMwMFZqR1UrN1dFMHN5VVZpQ2crMzRnMTBo?=
 =?utf-8?B?Y2V1cjBvak5QSkczMXRXTGdVS1NKNUpYU0NrLzZaRWgrZjFJNXRkYW42RFNY?=
 =?utf-8?B?aHR5c2pKQm1CTTZHSGlweS9IbXNMU1dyY1cyWEtUbnRDYXowZ0dIVDhrNlll?=
 =?utf-8?B?K1h1WEo2Z2JRa21NU1RIRkNrN0NoMHZ1cFZiL2RiWmpodTh5R2JwQVZ6bm4v?=
 =?utf-8?B?WnR4dnQ4dHRBTDNVUGlHczgzUG5Qc3VGTGRBejFkaTljeUw2YkhDaWNyRjZ0?=
 =?utf-8?B?NUU2THVEZjAveTdaOU15RHZxTlFkWEFUYUF1bG5ScmJuYUFUMEw3SnlpQTFz?=
 =?utf-8?B?Z0NXTXgxdFY0TGw1Tm9MWnBVK0M1SVQ0MVJuN1U1Z0FNaE9VejlkUGdaTVhG?=
 =?utf-8?B?NlFRVENMSTZROWVnOHZpdlBvQmdRQ0taRG9YWFBJWHZOdE1uRmN4Q3RBNnJC?=
 =?utf-8?B?RllEdlNzZCtQMVErbklOYWd2RWFxVDBvcm1DR2NyN0NYa3QrdjJqMFRJVTVv?=
 =?utf-8?B?ZGVFc3B0YzR2aVZsaGdZUGZINDEwdURpODc3WDlzeThhRlArcGFMeUxobXFF?=
 =?utf-8?B?Nm9pZDYrWEh4REQ3R3ZjalppYzhOUlhBM1FsL0xSc21weTM2K0ljSFlWM3A2?=
 =?utf-8?B?UnczaDI3L0FwRWYxbm5kTjJBOWxpbEt0UHRlcm9kdFRqa0gycjN5d1BCMXpH?=
 =?utf-8?B?SWE4Q0tuR2E4eVp4QzZTR1hONVNveGMrdzh3VnBrdEZhNlIvd3NMTmhoeklq?=
 =?utf-8?B?dDZEdGpIM3RCdlkzTCtIRWFVaHVlYitBS0EwY1BvNFhCZDFoeS92b1IyL2dJ?=
 =?utf-8?B?YzAvZXJjWTZITnpQOEExeVpZT3BIN09ucE9UcG5vMERqdktNRFFkai9PNWFK?=
 =?utf-8?B?NWl4bHNIRFlHYVVHQTVqTXIzdytFZ01Kd2lCenJGOU1DQnk5OWxvVHZpU0xR?=
 =?utf-8?B?eGxYWWtBY1BoZnMxOS9XbXZBUnFySHQzdll0T1hoZ24xRzNxamRyUHFaZG5D?=
 =?utf-8?B?Vk4ybHYxZ1pXa003a1VkY0hDYUNQSUNHeWhUbUhvMXN2Q1Y0V0lYZTBNY2NC?=
 =?utf-8?B?ZlVNNk12OHhhcjdWOERZSFZmajZPQ2ZVT2djVXNPSnN4eGc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0017
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e902460f-8a33-4198-7e1d-08dd9f58d768
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K05USVZZaVdjN3lIdEUrZGRJYXpBVHFtTXhXUzM0YlpYSllmTDVpRnBzcXNy?=
 =?utf-8?B?ZzV2emtvS2FML3lUbExERWs5V0xzM0U4Z3lIOW9xS2dqV0luL3BkL3doYnV4?=
 =?utf-8?B?YVpUQVFNYVc2OFA2SkhFZ1k0YWU0a0g2eEROTUJldEdUcWhNUSt3ci9SWnFr?=
 =?utf-8?B?bjREMDNJQlhCcmM1ZVRrbUlJVGRTQ1FLdXc1cU52UFIvWFpTMm9DSVpFaTV3?=
 =?utf-8?B?NVhVcVBFaUFCVjZqUTYrcVJnUFhYQkY5QUpsVGdiVGt1TkRRNzgvRFJHZSs3?=
 =?utf-8?B?UnFUaTlMV3hSdm1GLzlUVm4zQU9zRzVXMEtrd2ErZGVtbldjbm1TRkdNYlNV?=
 =?utf-8?B?eEF4c29KcjdMOUJMellRTkVNeXQ4cU00UWs1YjNiczVmMFdncG8raktwRHlP?=
 =?utf-8?B?THpMeGtSVldwUWx6QVdGOFN5ZTZVQzVPRXFvSkVhQzFFOXdzTDVqb0dMekxP?=
 =?utf-8?B?TWEyV0VmcHNpeGd4VE5lYzVDekhJbjNXdzlWT0lIWkFyWlB4cDg4dE9OUmc1?=
 =?utf-8?B?RC82dUVOeFVFV1kyaXJNWHNqenQwWnBwMmFpU01pNGFFMXhRV2FCYVgrWDl3?=
 =?utf-8?B?a0hqREF0TldDQ1FBdDB6SGdmWWJrZTdEM3BicVZjMy8yK2U4MitkWUk5SFhu?=
 =?utf-8?B?S2pPTFlydUZ0cXNxMG8zU2xiNUc5dFJHMGludDNoLzB4OExIZHBHZGcrTFdP?=
 =?utf-8?B?TEx1MFhwMzNNaWVsRjF5a0Jia2JvTlM0K3IzVW5NNndmSW5PY1Zsa1dwcjVF?=
 =?utf-8?B?b05iU0YwYXV1blVVRElDT2hFcHJoRUZsUERKWEI1K0RJY1RJcEJsTXJYQUFD?=
 =?utf-8?B?Y04rblg2MTNWS2RNQXNUbTRaNDdvNndBTE9kQjJwaVM1bUIxS0FKd0h4QVk3?=
 =?utf-8?B?czUwZmVEMldtWFBYbVUxUDZZenIvelFNcFI4eGRHby82bU1MaE1ic3orTldm?=
 =?utf-8?B?WVVON05uZGNLMDltY1hieDBLWFNxMVp3cTlhOEpPUnlTWm1SQkloVHUzVlhN?=
 =?utf-8?B?emRsTEFRQTZjT0lreDRtTUdiSFV3b0w0QzFsS2sySW50Nkl5bm5JTm9qcENo?=
 =?utf-8?B?NEV0M21VRmxWV3Zocmk0cm9sUzNYTUxJaklvQWkxc0NSTXdLRXV6MWZKemli?=
 =?utf-8?B?NEdTSGZDY1ZoQ3grK1o3eHVkcm1BNitQRFNva3lHSW5SandzYlpTbDU4NEV0?=
 =?utf-8?B?eTBIWlZNakpGUDlYQ1ZkY2c2dXZxajVmWEFxZDBjNUszekVwcmNJN0lZTXhX?=
 =?utf-8?B?N1o0MGVnOXNNQk5YL01CZC8xKythMlpaMi94YkVDamxXWklOVko2V1VQa29a?=
 =?utf-8?B?bUkrMHVqTkg2MGVxTW9zVnNLNy9sQUtGclZzWDFrV3hab2p0SzNweUptTW5D?=
 =?utf-8?B?ZHE5YmxJbGVYcXhnTUFNOWdwbFRuZG1UTWZtOUJTRGUyZ2NLWDc1YTh6bGJj?=
 =?utf-8?B?QmtDVm9oaDFrRDBnT1hYejdRQ05qMXl4dHk5YUV3WlUwcTVsQSt2UGh5YTBV?=
 =?utf-8?B?ektlRytpVCtQQm83TDgzMkd1ODcweXM5K1hQVGZKeHI3dk9kVVJNVGkrL3VE?=
 =?utf-8?B?R2NPaUd2UE0zN3JYVzRwMUY3MUY3bnY0YVhtZHV0dWZWOUlsZVFTRlc3bTRt?=
 =?utf-8?B?NkdPOExFUlI1MWxpM1ZKcDM3L0wxK0VOOUhHeUpVVTcxeGlXODRIdDRUZGJF?=
 =?utf-8?B?QkxQVSt4M29oZk1VUElpNDN1djUyWUtnSFpuNFpIcVdNd0gvUElGOWw2d0FJ?=
 =?utf-8?B?dGR1WW4wdlEwckxVbXJwMDJMVVY1T1l0MWxVeVpjQVJZRURQVWJvZWErOUVt?=
 =?utf-8?B?M3A3MnFPZHdKa2hQWUtabzE2bi84RnRRcmN3bXQxOHJkK1ZuS1ZLTldjZWtO?=
 =?utf-8?B?RWdjWGJUN3hLZTFUcEtMZmFBUXMxaWRuTFF3Zkk1dmg2ZWh2dXZlQk9FY1BL?=
 =?utf-8?B?MDV0Zmt5YzZxWktzbEM2QjdXQ0hCck8wWU90ZWVuNDRaKy9Ybm1WY25VWDhO?=
 =?utf-8?B?cmowVi9pb3hvcCtYc3g4NFd6NmNJbGJrclRtNW1kYmhoQkNudzJyRkNIZTEy?=
 =?utf-8?Q?YYMPqX?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(35042699022)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:03:29.3470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe581962-16c0-4a5b-340e-08dd9f58d87a
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0066

Dear Cachefiles Maintainers,

I've observed that when using cachefiles there is extreme performance 
degradation when the cache backing file (i.e. in /var/cache/fscache) is 
severely fragmented.

For example, we have a 40GiB file in a NFS 4.2 mount (rsize of 1 MiB), 
that fully resides in the local (fs)cache and reading starts at ~16MB/s. 
Reading the backing file directly can be done at ~500MB/s - the hardware 
limit. The backing file has ~200k extends and resides on an etx4 
formatted SSD.

Using perf record, I found the culprit to be iomap_seek_hole (caused by 
cachefiles_prepare_read) and its descendants, which account for 98% of 
cpu time, which in turn is almost 100% of the wall time. So the root 
cause is that SEEK_HOLE is too slow when it has to traverse lots of 
extends, at least for ext4.

I've verified the time it takes to SEEK_HOLE manually and found 
consistent results (66ms) which behave as expected: the further one 
starts into the file the faster the seek gets. This is also reflected in 
the read rate through cachefiles, which grows in a 1 over "remaining 
file size" manner until it achieves the hardware-limited speed near the 
end of the file.

This should also affect all other filesystems, that search for holes in 
such a linear fashion - which I imagine is most, if not all, of them. 
These slowdowns will mostly affect fully cached files, exactly the case 
where one would expect/need the best performance. They are also 
exasperated by smaller rsize or when cache read/fill patterns induce a 
lot of fragmentation. Therefore I think it sensible to address this issue.

My naive impression is that using fiemap should help mitigate the 
impact. One could still fall back on existing SEEK_DATA/SEEK_HOLE 
behavior, in case fiemap is unavailable.

While I wouldn't mind (attempting) to contribute the necessary code, I'm 
not too sure that my non-existent kernel development skills would 
actually be helpful.

In any case, I wanted to bring this to your attention such that you at 
least may ponder about it.

Cheers
Benjamin


