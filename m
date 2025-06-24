Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022073.outbound.protection.outlook.com [40.107.168.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3128D8FA
	for <netfs@lists.linux.dev>; Tue, 24 Jun 2025 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772694; cv=fail; b=P/fwW/cUchFW6mo7nsuB+S9KeEEERUR5wmxFavRqPL2FEyXCOb6+ZMObYEusWtHmOVFQ8lbNXy0/rKZXTGpqYiYw62PaEhb1feiAZAfVhCdrzYNvwJDqzcaoawxDBr6NuVpol5h21e6DS+6GLRKEvOlEaUveNBsceSzG50kj4dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772694; c=relaxed/simple;
	bh=hO6F3sRBIiENlWRPfH6irTWfRzpHgt+2LS+K4pjTeWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Etf2V2crpn25FTWpKXeXuT4D5DFozyJAbeifaEgiJZW7gAPeLkISFQdACgVErCzCGvQbeTk1VLeeXCVNqJbVwnPdj9gCECmHql1KpOBVHW3N0Ok55jHDiM+P3g7EGWBeESUpFvY2hvXkCArGIWwYznWVjq8r1gpLidUCQwpTS8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=M0vY4iTQ; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=M0vY4iTQ; arc=fail smtp.client-ip=40.107.168.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="M0vY4iTQ";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="M0vY4iTQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyTB8lQF2l2tocfycgp2UPgf8BPyMtFCB4h7vUeOgdy0hTELXr0wfFjGvJHL1kw1I1gU1b2WR9t7qPndfH9JVW4LiwXaV7rpDpGL1bQMXwBEGojY0K3w2tZNTFvDNfVTxHeGhpR//vOl8RBoS1QYHTFmnYPBEqjtP99z8SXBr73fDyePHpZAi1srUD6rYL+H+rqFIduQuk81DL4899VjY7UBOZAtDX5zOwY8z6QCrZpm2EysRIfAJrrJRkKleN8+Xf2WWNrjldskH1FDODGVTE5Hz2K3OMxzlGv8a/R2tTFEzK1znOQlCKsHEb61KzrkKFCzv/ODen6RRN80s31/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOkkGXek/NME863mp9OlMZkhnvaTJivyPebQjN8k9ME=;
 b=GjmCC/CD+uNaqf4HGarFC3nL54z3RcpcOBV2Emo8PJq93aJcV9/faY5OfDNTsFDr0IMxWusUD33sCEKWs3XaB9QpIv6iPqu7I/PYpRbGzJvqN914OhoL+lEwBximUERCBnfbyWUMT6tpEK++r+wqAburfiDeW6rq55zs6IfG3MnH+OYeR+HX3tZaKMX9BqshwNfKaA97Woq0HYyGAZlDVxFm2N6ZSsdwcBvZ0e4mY1x/+gGni6dWy7dQvZGFsiwP5r2xIighV9rv8lTe4dFvYbanoTpvJIltkC2QRa+VJBaZsiISqURo+QOBRXWi84p56pDTlL1aKqJdAT5FHXIhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.16.99) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOkkGXek/NME863mp9OlMZkhnvaTJivyPebQjN8k9ME=;
 b=M0vY4iTQrQ8o1Cya5TIXQxbvSnuJzAtsYIPiGi+H4Dq2q0rtkq5fDKUy6TCS0tyVTQtAV3VMKRzh6Kpd6ngre9nXqDIEH09Usd+dvI+NvsK4rkOu6MoN5TqPC/HGxj+Tb6NkTBWg3VEbL5ZELcDXddco3xFJ0aUksKfGiF07WIU=
Received: from PR1P264CA0156.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:346::12)
 by ZR1P278MB1343.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 13:44:46 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:102:346:cafe::3a) by PR1P264CA0156.outlook.office365.com
 (2603:10a6:102:346::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 13:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.16.99)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.16.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.16.99; helo=mx4.crn.activeguard.cloud; pr=C
Received: from mx4.crn.activeguard.cloud (51.107.16.99) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Tue, 24 Jun 2025 13:44:46 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=M0vY4iTQ
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011024.outbound.protection.outlook.com [40.93.85.24])
	by mx4.crn.activeguard.cloud (Postfix) with ESMTPS id B5B4C83201;
	Tue, 24 Jun 2025 15:36:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOkkGXek/NME863mp9OlMZkhnvaTJivyPebQjN8k9ME=;
 b=M0vY4iTQrQ8o1Cya5TIXQxbvSnuJzAtsYIPiGi+H4Dq2q0rtkq5fDKUy6TCS0tyVTQtAV3VMKRzh6Kpd6ngre9nXqDIEH09Usd+dvI+NvsK4rkOu6MoN5TqPC/HGxj+Tb6NkTBWg3VEbL5ZELcDXddco3xFJ0aUksKfGiF07WIU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::5) by
 GV0P278MB1417.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.30; Tue, 24 Jun 2025 13:36:32 +0000
Received: from GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2ca8:318d:37c1:fcd]) by GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2ca8:318d:37c1:fcd%3]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:36:32 +0000
Message-ID: <619bca7a-d89c-4262-8c05-1ac536db0a6e@cern.ch>
Date: Tue, 24 Jun 2025 15:36:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Cachefiles slowdown caused by SEEK_HOLE
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
References: <31cd8f34-1b37-4062-925a-baedec8f2f79@cern.ch>
 <963373.1750426130@warthog.procyon.org.uk>
From: Benjamin Fischer <benjamin.fischer@cern.ch>
Content-Language: en-US, de-DE
In-Reply-To: <963373.1750426130@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::15) To GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:54::5)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV0P278MB0805:EE_|GV0P278MB1417:EE_|AMS0EPF00000194:EE_|ZR1P278MB1343:EE_
X-MS-Office365-Filtering-Correlation-Id: 607ba822-c946-4db5-27e7-08ddb3254887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ODQyZzFoZDBQNWxkTTVaL1pvZXhpb2cyMVhVVjg2Sml4anRFZUZSNVpBaWk1?=
 =?utf-8?B?ZWJ4TVg4OHEzdW9pcnpQaGsyQmRxRHNxTSsyWGVTcFlacU1LWDljb2dFU0Qx?=
 =?utf-8?B?ZEVKam93QXZDV3pReDJrOFZLK0RZMHkvYzROaHZlMmtTRUtlVFM0b2NjbU40?=
 =?utf-8?B?bTFUYVJ0N2JYck9LTEx3dktJMEpXUUNqcDZOKytWelkxazBUTEdrYjBERHlH?=
 =?utf-8?B?cDU3dEEyY0NRdU9RT2J4dDFLNnEzVzVRSjVoQ2dyV2taeDY5RlI5Q01xTnhm?=
 =?utf-8?B?Z2k3WHZuZ2kybHEyVFg5U213ODdUeUJlc1VJQ29lcGRTY3A4dnJaSzZlZG1l?=
 =?utf-8?B?SDdMdUFXbDY1Mk1TcGhnNGplMkxhVFEzWVFFQ0UxMDkzVnI0Q2pVUExscU9X?=
 =?utf-8?B?UWtOejUyWVpoemh3RW5MSjIvVGVRbXNHWlBseUVUYXJBb1U1MTk4VjZFL0l3?=
 =?utf-8?B?Ly9IR2tYWkg2RUFsajFtS1NQVXh2eURQZVlCNVlBNjRIbEs4dXUzN2ljZkZR?=
 =?utf-8?B?eGxOa09ValVUWHJNdDRvVTNHV1JiQzYvd0RaZEN6TW8vYmI4V2I4L2J2TFk4?=
 =?utf-8?B?TzB6NXc1ejA4ZXVvTTRhdTVVSmVFcDN1V0wvam4rS0ZLR3d4UHRVT3N6UFF0?=
 =?utf-8?B?T1BpUk4yV2pGMDA2NHZqVkN2aVpYNm4xUXh2cC9CckJHemZndnZwS3o0UjdV?=
 =?utf-8?B?elBKQWdXK3lXZVBvOGRic3Rwd3BnVmRtK0hneHpQRmlsQVdvQVg5cVRXZzJV?=
 =?utf-8?B?THlyclR1ZElXMFdPSjBydzNNWHc3TjNtM3dkejJ0VFBERDFER2duRFJiazk0?=
 =?utf-8?B?V1AzZThacjFobldiVEVhSkYrYmp5cWsyZVVuZG5idlBPN3N2cXgvdGpaQnRa?=
 =?utf-8?B?S1VRN2pNTGNLL3RRUG1PU3NqTzJyellJTThrRTNhMktNSHVrWTlzZzdaalZ5?=
 =?utf-8?B?U21UL3hUcVRzT3NRRnQ2ME4wR2RHWjVCc1pXNVgwcGZFaUQxKzE4dU44WE5S?=
 =?utf-8?B?STNYanR2WHJ3OG13SzFTYjArMkt5b1FYTnZnU2NqeUxEaWt6NjlHOWQ0VXJZ?=
 =?utf-8?B?bHJsTm9SNzVGOTg2NE02R1pCakthMjVwY0VlSVozMjJlQ2tHdThGeEhlUjA1?=
 =?utf-8?B?N1dNN0RmbDNDYW1XdlA0ZnBqL3BxWm4xQlpkOU8vMmNrdGFqZFphZGl4b3B5?=
 =?utf-8?B?bHVIVjFaVmtLamFseStiQlNRWXdpcytoNFdmcGQrWEhJOWFoVkdJZWJkNlBZ?=
 =?utf-8?B?TTM0SVBUU0VveFZ0NmVpSVdvOVo1a1F2NEMxRVBCZ2ZYSnV2MTZjTjJXT0JC?=
 =?utf-8?B?TUdraXFLeWZzOGtoU1huSytCbXJuMEtaWVVrQnUwVUI3WTBlZkNzK2VnTVIx?=
 =?utf-8?B?V1lTZjB5WW53YmJNMlBNSmJxMWc1KzltRkkySmUwa0RIdHdxaUgwb2lMS1dZ?=
 =?utf-8?B?dHFoNkdJVHRHZWFwQ3dQVnR1a2MvcEY5dFlyZG9Pem5UdWFpUU93MWV4TWRz?=
 =?utf-8?B?OEpib1FLalA3ZUpCdmsyVVFPRmh0cHVPK1ptajlhNHdRVlI2b0VaMVY2SmRV?=
 =?utf-8?B?bDYzdWxjcEg0ZUFtQklHbWFKUnZxbGczKys3cFNOUisyUFdJdEJBVXIxUEYy?=
 =?utf-8?B?SjNyRnVLQXRlSjZwUHFuUFdiNnVGZzRFMW1iS21GNnJRWlJuRGZGWDVudE1y?=
 =?utf-8?B?TTJXUXc4ZVpzN3c0Q3UrUHoyUXk2T0pNeitOYnRheWdkaUtDRkl2UXhaZXBz?=
 =?utf-8?B?bkN0NFVwM0xGYnBSUFFYeFRMUjI4ejBEOWRYRDg0MmFnRnRjL0FCTE1jcSto?=
 =?utf-8?B?VHRvZnU2Q0hKSU5RK0h6dHIzWFpmV2lHZ01kTWx1YzBxS3MrUkZmQUk0ekZH?=
 =?utf-8?B?Qit5MkYyeHdTcEtIWFhqL1ptcE1OZzlXMFhSb3RYSGJOSjlSV21hNTcrcGs3?=
 =?utf-8?Q?UsVl98Rytgw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1417
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	431a8240-6dd6-4454-0198-08ddb3242175
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|14060799003|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXdCa3VPR1dzT2gzTDVoSVNnalBMbW1XTkl5U3BuUHVzdlVxQmEzbkMvcHZV?=
 =?utf-8?B?M3JXMm5DbHpiRWU5YjNKUVRTSXBDRXJOYTV1U2ZUK0ZrdnhVUjBoK3JtZldw?=
 =?utf-8?B?YnkvczBRVzZJZ0JxNXRnRUJRd3JQMHpnU29lYUd1WTBROWpHeS9Ta3E1MVZK?=
 =?utf-8?B?cDFlanV6Sm1KZlVCL0t2THlRSnkrVEszbjB6ajNXZ2ppM0JuanpBT1VXYzlY?=
 =?utf-8?B?azdReFBjSVFoOTdpeUhZYzNtcmdENTZWSVpqNUhUTC9UNTNOVkFUc1N6aTZH?=
 =?utf-8?B?WWR4K0dsL2JTU0MveTBsNmkyamR6RHJDSDFGMFo0Q3R0blBueTI3cHJMRzJ1?=
 =?utf-8?B?K1hEMDN3dm9Sbm5QNGtjbDVnUEdPZE9CS0xzUkhIVm1pUWhKeVVna0p2Nzlr?=
 =?utf-8?B?V1hWRmR6aW1yUFpLYWwvK2JjNUsrMnhSbmNzejZncmN2SXp2eEllM0UxS2xu?=
 =?utf-8?B?SVk3N0xTQ1VqUENWajF3b3pmU3JVMlg1SjNWUFZaaTNUc2NDaDNUOHRSK09X?=
 =?utf-8?B?M2tGTDVkaEdhaDFjRTBSRUdRR1NvbHU5WFBCYW5KMnpudEZITG1oajlDSUts?=
 =?utf-8?B?NlFZNmNIclhYVnJlV1hYdzErY0I3c3NOV3k2YUhlclUrUEhXWHRFaFlEbW5k?=
 =?utf-8?B?ZVFkY2c3U29IcjBKTE1yMU1BYWlXY1lCT1BFSVJtRFFmK21kRXFOcUNkTUxN?=
 =?utf-8?B?M0hNZUVUM2ZWQnRkU1pxaVNoajVrVDBEWDVPeHpCT0tpZUdIVFZWUDdCQVhz?=
 =?utf-8?B?YzlSMWJOVTBKSzdOU0VHYndzTG9ZamtQTzlLbXRoS0tTR1RkcjY1eWJhcnJu?=
 =?utf-8?B?WkRudUN5cEthN1YvN3dHMGZBTnoxdnhPa2RzYU5KTU9zZlJRcVllTXNpbnpw?=
 =?utf-8?B?OVgvRjdhZEhRNUtDRENRVzNPaDZaVkxiQVR4dFRLd3lUQVFWRlc5MmJJNG85?=
 =?utf-8?B?eUJFaTg1YWhPdUxnd1RWSDcva0FsK3JJQVdkVzZzNGwrTUd0OEVmd2N2Mm1W?=
 =?utf-8?B?SnFpc1FGUmUzYjM0aHdLbmhQTlBmWXJqUGRFeVh2cDQ1M0kzUnc0YmFnVExa?=
 =?utf-8?B?ZnQ4WkhCaFFKOElqT0hQRUFKb1JKUHdlVDFUVU4xTTVCTTg5ODlIa1IyZDJR?=
 =?utf-8?B?VzVCcWwrdkM0RTN1TGJGMkJJcnRlRERGOWozY2F4c2l4VDhjeHh4bnRCL2NT?=
 =?utf-8?B?a05yNWVjYnJJS1NIbVpDSGZseFpTTHJwMndTVGEvRkUrL3VtWnR3SDRwcGRQ?=
 =?utf-8?B?enIybUNCeDd6aGlZR3QwWmgzRmZzQWk1YjhUY1lzRUdCei9GSC8ySkpscDFw?=
 =?utf-8?B?c1NVZHpEa25FdytjUGVCOUJOZEdrZVRRZm0xVmh1cyt5RXN4TTl2RlVIN1hy?=
 =?utf-8?B?VStQalRXUWRRd0tKNHl1Y2pOYTlFSjF2UjBEcnhNcmtxL0lIZS9FcmNWL3FF?=
 =?utf-8?B?eXBZWHg1aVlTNzROZTJPRTVXOUZ3SzRTQTlvaVQzYUliOHNvbUo4Sm9jYzRa?=
 =?utf-8?B?NXp6ZVRkaHJSQVNGK2Q3K2wyY2RkSjhPQ2FsMGpqaElIcFlRME9FRGoxQWUz?=
 =?utf-8?B?b0Jua3lWTFJoZlY1VWkzNUh2cm9rSldvNGJiRWlZTjRXUmlSQlN6b3UvTEo3?=
 =?utf-8?B?dENGb0JxeWw4Qk9ZNjl2Q2xSakcvdDZvQ2lhMTVzck9YSmJsMHlhWGVtWklJ?=
 =?utf-8?B?N3ZsbzRvS2MwUllSVnpmK0NUMEtTa3JzKytJcVFqN1dmT1FvSGFLYmU5QU03?=
 =?utf-8?B?N1ZxbEZBanBYaklBTmtwZTllam51Nm92QlkrRWJsaDlZdlRwNEFwQ25TZzdp?=
 =?utf-8?B?OElPS25WYktRNmFDeXJIT015MUdSa20xQVZGbmEwbmlreEhOSzRBbS9od1Zy?=
 =?utf-8?B?K0p3Lys2Tmt0NXlHMkplTm9IU1dwK1loc1hrU1hEbnhwbmpndHEwdzVvQjBI?=
 =?utf-8?B?Y3k4VTViMHJaYk5LT1haNTYrVkhpc3pTWDhpOHJhcjRZczMxMzMzRFpRcWRH?=
 =?utf-8?B?THZBRTlmbE5RRzQ3VzB4b3MxZzg1K3BzK1NxRHk5cHh3N3pOQVBoNUR5eXpr?=
 =?utf-8?B?dlRzY2RDQWRjRkZhOHlUZk1WSzFlb3RLTTR5UT09?=
X-Forefront-Antispam-Report:
	CIP:51.107.16.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx4.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(14060799003)(35042699022)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 13:44:46.7757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 607ba822-c946-4db5-27e7-08ddb3254887
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.107.16.99];Helo=[mx4.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1343

Hi David,

thanks for the detailed explanations.

> [...] Unfortunately, the ext4 and xfs maintainers think it's not
> a good idea to rely on the backing filesystem metadata as the backing fs is at
> liberty to punch out blocks of zeros or insert bridging blocks in order to
> better optimise the fragments list.  The former would give a false negative,
> causing us to have to go get the block again and, worse, the latter would give
> a false positive, making us think we have data that we don't.
That it truly unfortunate, since their allocation bitmaps/extent trees 
exactly cover the cache's needs for bookkeeping without implementing & 
tuning/optimizing it twice.
> [...]  I might be able to use
> FIEMAP, and certainly caching the result of the seeks ought to be fine... but
> for the small matter of the aforementioned possibility of the backing fs
> screwing with things.
This seems like reasonable compromise until the underlying problem can 
be addressed in full - which seems quite challenging.
> I have a solution that used to work (give or take the odd bug in it) until I
> was persuaded to shift to creating netfslib and still have the code hanging
> around somewhere (it needs updating).
>
> Here:
>
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter-dir
>
> and, in particular, this patch:
>
> 	cachefiles: Implement a content-present indicator and bitmap
>
> The way it works is that you define a 'fragment size' for the cache file, say
> 256KiB or 2MiB, and then divide the file up into blocks of that size.  A
> bitmap is stored in an xattr that indicates the occupancy of those blocks.  If
> a file is completely stored locally, then we can dispense with the bitmap.

Using bitmaps does seems like a fairly straight forward approach, but I 
think it is worthwhile to consider the details and consequences before 
committing to a particular solution. Especially, since the use of 
bitmaps have shown to have disadvantages, at least in filesystem contexts.

On the use of bitmaps: choosing a large block size can drastically 
reduce the efficiency of the caching mechanism. For example, one of our 
use-cases relies on the fine (4KiB) granularity, since one of our file 
formats is internally heavily fragmented and only sparsely read. In 
particular, the fine granularity of the current FSCache implementation 
was the leading reason why we chose it over all of the other options - 
so it's a quite distinguishing feature.

> This has a number of limitations:
>
>   (1) We limit the xattr size to 512 bytes to hold down memory usage and, also,
>       we can't read/modify parts of an xattr, only whole xattrs.
>
>   (2) Because the xattr is limited in size, there is a limit on the number of
>       blocks we can map.  For 256KiB blocks, with 4096 bits in the map, we are
>       limited to a maximum of 1GiB.
>
>   (3) We could have multiple xattrs, each covering a different part of the
>       file.
>
>   (4) Setting xattrs is slow as each one is a synchronous journalled metadata
>       operation.
This could be resolved by avoiding xattrs altogether and instead using 
the (already) required support for sparse files: One could store the 
file contents of the file at a (fixed) offset into the file (e.g. 1GiB) 
and use the space before this to store the bitmap (or whatever other 
information is needed for the cache). Even with a block size of 4KiB and 
offset of 1GiB would still accommodate a bitmap for file up to 32TiB 
which likely covers the vast majority of use cases.Would this be 
feasible? Or maybe has this approach been already rejected?
>   (5) We have metadata integrity issues if we want to evict an bitmap for
>       memory reclaim.  We need to flush (and maybe sync) data from a separate
>       filesystem before writing the xattr.  This might not be so bad as the
>       main metadata xattr on a cachefile has a flag in it that says the object
>       is under modification, so we only need to flush, sync and write back all
>       the bitmaps before altering that flag - and this can be done in the
>       background.
I don't quite understand the intricacies of the race conditions you 
refer to here, but I imagine this might also be simplified by storing 
the bitmap/metadata within the file itself.
> One reason I haven't progressed much with it is that is at the point of
> turning into its own journalling filesystem... and we already have a bunch of
> those.  Further, the point of cachefiles is that it uses files on an already
> mounted filesystem so that you don't have to have a dedicated blockdev for it.
Oh yes, reimplementing something that has already been done several 
times over seem like busy work best avoided.
> An alternative method that may prove fruitful is to explore the way OpenAFS
> does caching: by having a bunch of, say, 256KiB cache files and an index that
> says which part of what network file is stored in what cache file.
Such a implementation would probably be useful, but just like using an 
extend list/tree instead of a bitmap, it is far from straight forward 
and as such prone to implementation & tuning difficulties.
> But if you're up for having a crack at forward porting the bitmap idea, I can
> give you some guidance.

Thank you for the offer, I may take you up on it in the future, but I'm 
currently short on time for such an elaborate project.

Cheers
Benjamin

