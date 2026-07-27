Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E23C1412
	for <netfs@lists.linux.dev>; Mon, 27 Jul 2026 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150548; cv=fail; b=M4/NsiCTyQ3RZ501vIMF/WTr647BD5ognd9lTFZSrtphCLhz5kUd+SZzgVPDtjdlIHdAXdU4owQQvlqUssEf6PncYpnbCphP6/KpRhOJLbbnOeCSPMvFoAVGpE2meC1yPu7y0sziU3niDG/x2ryrJkDLcy135tES6wwKr3Ub/l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150548; c=relaxed/simple;
	bh=IQsgfSOkg9Oqkic+CVemV5UgjKtq5zBFodIJcuxpnSQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VxV0SkxrtJCs0uBvrKDOfIGezIBmYPAeqkgJWPesjx6odnM06yBRpf3+cHB3iW6Fs2eHg06EwCoepLVcTRfoKzqVFfdoWN+kdRaFWLgBGKwnChlQsYVP6tsx8aWXs5AKbLVgmEQTsggYNV/q4JtSSWho2Vc9Y7yN/NTHFzz0QZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=A1wvD8lD; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="A1wvD8lD"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAO2FP478054;
	Mon, 27 Jul 2026 04:08:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=DZSwk7wN1/B60oFYFFcRPlPhTLtwhUv2mBfSO4/IGS8=; b=
	A1wvD8lDHweomLDKrO7GLQ5GmD54f24YbzMEO+fBtTrhcWRTPCtn2ffjGIi3yIID
	kiQ+5LMlM98lB6jhRXLPZ4q+xhIxzTRqsUr11uQUviqkQOLT7XazKJaa/Yv1cn0s
	h2ZOOMkcROzNa4edhVFk4qoqvVoivzs4KnLXVMuF4/v4jwpGVIewRq0Xsg0uhH2X
	tYG4kkD0V+Z7OW2VRQqWSrIOzlGYxLFPYJ/dh5XEGfqjKqmgBwvHAEJdM1/R6cpk
	AWxSC6zfVh4VQj/zIaoZwIeo+c/ZJTgL4x08ToWbdLwmvuxJ6RK3Ly/6mjQ9Axtt
	lnfuBVUVOOEFwrEWRTRpZA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fmvnf1rer-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 04:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuu9k6p4rYLprLajddL+PbbRmU7+zmZxSuoVWn3FbQGhNy6Fvq1b/74jbteUskH+Kn19fqJLwCiNXleztKapijmTO6U+9Rbe7EFqlc20VkF0M5eKMAR+XH3eoozO6RAHdc8RW1YtVrSmqH5O7/1hp61Ac9qMtB6v0nEgGPPy+JeoH/OFxcuz9IcE3egkX1QVW4bLPk/UhqAjL862JGacjtxq/Nk48T85/PDigiDe2P9ngxfEWd1yZt4DEVh96jMcs06KCEWKRWDkW88KVRfiPGlw//1YjoDL7CkMaASEThDjX2Kky7DibRAlNszxsjqcSPz60JGaIeOBDPbzzx0HFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZSwk7wN1/B60oFYFFcRPlPhTLtwhUv2mBfSO4/IGS8=;
 b=soFR8Le1BjzRlm2/Rn4dCzMKfvIodQYIFmrSUY1+6fgyI6HuiUutR+xZU1Tpa9QlT3gQO+l5AI0R/wVHgv5ZrbQLZSmNUSAIB0aRI4iiv1PA1vQu/w7wW9YjC04Rmw7xIIkt7QVnp43I88gboynlkjKSd+gWQrRFdKueEhF+E1MYamSCbmzjyFoD7GQspdR5Lbn1Vaw9pbXUsqxBTKE/fJOxp1mSp1Lzk/7oduAgqy51zTGbDPQP9L40r7T9B5ZQwYO535nRVKQFVyHrbKKOrvFHmBv3gqFyCQ8iCvZ7RqdiS+yTFZrK1tboZngzYYkVwT3ZcDc2CPC3KWJ/HS+q4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 11:08:45 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 11:08:45 +0000
Message-ID: <2e003306-e6cf-4b4e-a0cb-19beb1ea08d4@windriver.com>
Date: Mon, 27 Jul 2026 19:08:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] netfs: fix writeback ENOMEM by using __GFP_NOFAIL for
 rolling buffer
To: David Howells <dhowells@redhat.com>
Cc: pc@manguebit.org, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@infradead.org
References: <20260724073044.3400217-1-yun.zhou@windriver.com>
 <974342.1785146612@warthog.procyon.org.uk>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <974342.1785146612@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|SJ0PR11MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 90dca57e-eda9-4f7b-1298-08deebcf6ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1LScPBYT8k3RuX8XPrT73yLY3ieaUUaUjuNqTcbp1hnQeRm0N7COdXwgdR5f0TyGQb9+j4OfhecxR90+adm8KDMhy0QIqJtuGVhF3h7GUV9ACL5M6TGaa40sCLVdymt0Hcepi30X/2luF4wEwwlBnecxNAXSJZmKBzhgSpvy52wLnzImiAk8XL4pOgYS6TsfIpHRTbUzptd/MlvhyxrguIIkpzSYDQfqCa9rMB/O5PV4dxwiuLtnesOFbMXxky9LwJpP/EmBM4AOQFlwAeSgd+uLUM0EExTFW3zGWLU7m2GCVa2CVb/VjF4LFf6j5/d+LSbzqNtPGi2SO+4kZFMTpPRfKQ0/A1mfhaf3li9Hds2HJ/TadWZVJ34H6Gx3iUz/+7wvKZpEdhDOWOxhgagi8wQM7T0eceGpCI4tIdyYxrdXWgMh78fhA3Rl+nrA74B+XuTvUHv9r7dDANnfe4lLzcyUxmy47gPr3xfu3DaXPQ85jXxaYcLzQ2AsQVWeAWsvXNGnW7q7AXh8gbCabjjhrTYjW6FCA2Vx220WZ4hOddbDzdFGFJmd4hsneY8KAVgGS1re3PE/8/+d+WrujYjCT6Kui4i9X5xGzbYTPIlnolR2qfxZjZ6b8D0i96QZY892m9I7cqZVsFpuIGx/0h02byDQnV5a2XGm4XxGB4JBAwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVdjbFBWSG0rSDhlc1QvUElBbktjSUhhc0JqaGVCbC9JZ1I4K2tsZVh1RWU1?=
 =?utf-8?B?MGo1Z05vN2JWUDNjMWVTdlY1eTlTbUQ3blJwRXR4V1Y0OEUxRTFOZE95OUdJ?=
 =?utf-8?B?bi9XYWszU1Q3NDVaRTFmV2tBeFZqeDE4RXZIL1p3dk4wcGMvUTVYb053TVht?=
 =?utf-8?B?eDF0ZWFaZzJQQnZjVlpQb0U4NDdpVkcvc2lMVlllTDdGTENqVndjZHB5ekZq?=
 =?utf-8?B?VnRVMG9SV1lPN3Nkdk1HZmVYYTkyZG1wUmp2ZHBiSktXeVpMdmw5blU1M2NF?=
 =?utf-8?B?Z0ZrRGhoQkE1U04yWStMT0FsR3FXV28xZ3dFK3k3YkVrcG5VOTl1UmpsUUEv?=
 =?utf-8?B?M3h1Lys1VHFOQkpUb241WG9PZkxlZmg2OEs5eDcydVZjTVQ5UWlKMi9RYXVI?=
 =?utf-8?B?ZnRFeWJSN21wblJZaHdPQ0RYZnB1TjRFQU9wZDhWWTM3Vll1Q1RCUW05WWpN?=
 =?utf-8?B?WnpvRS90YjNTUGZ6c1hPUTBTV2UwNlVSMFU4emxuQVFVYk1OR1dZbmZRUWlQ?=
 =?utf-8?B?c2MzeDVScEhNTDR2dG5sc3JUVUpTaW1SdmQxOGI1b3hSYjEwNDcxU0ViWWV3?=
 =?utf-8?B?Q2VhWUx1eTBVL2FWWkZvRXF3cEZYeG5JdlY4UmFjRlJnNXd5bUFVTTdob1o0?=
 =?utf-8?B?bXFucDdGaVZ3SXlHenNTdi90VnVZd3JZeVZFcFV4c2pBalo5QSt3UFdBNGZU?=
 =?utf-8?B?N3E1cWdXN0RnOEVxWjFBQmEyVlFEYTBEZGhPU2RpejM1STFCMVY2N0dLYWtk?=
 =?utf-8?B?ZExoRCtHaS90enZtQXBSMlZubUFhVlp6OVFQMWplSU01bEtSRU4xV1N1RGo4?=
 =?utf-8?B?cDQyaGNNazNwKzdKU0pLUm1uUlJWejJnWlFhL0VHekpGTnE1QWJ6bmdQbWI1?=
 =?utf-8?B?UllXQzBLU1h4MDBhQ2RXS0tPN2FwejFENlYrMlJ5ZHRwK01zcER4VUwzbmN2?=
 =?utf-8?B?V0E4Wkx2NE9mKzRzQVhMNVBjeW1Yd2hwN1FBeUlmVEV3YUVXSDA5eTBzeTE0?=
 =?utf-8?B?eWg2U3BHYmhlTUlLUXk3VHJBSEhPUkhUa256bHhlSWt4SzFTRlNwWGFKU2lx?=
 =?utf-8?B?YkhVMW1jNnMydU0rQ0xWZlV5cWFmb1R3RXArdHpFNitlWWR6VzlydXhoSUtj?=
 =?utf-8?B?RnRrVXNBMXJkd3ZhdFJZTHU3NmROdUM4WWpsemNrQ2FLNVZRUHp5M1RJVWdQ?=
 =?utf-8?B?bDZwMWl4TFZ5bFlIUHZYb0pkOURFd1Rna0JsKzBLMUJtQzEzaG9CQk9WeW56?=
 =?utf-8?B?LzhBRDE4UXJKM3F1dFFNQi84L0MzSmdMZkx2cXJ5ZFJKUUtmQmJWVUwwV0x5?=
 =?utf-8?B?ankzM3VJdHhlckdpdldSSERjM21hUnl1c0JQTzg5bU1FaWw0RUxjWjR1SUJj?=
 =?utf-8?B?NTdHMHVyUEVTN0ZwdjUwd3pENnNzaDZKeVY1VnZIUWJrVWhBRUpSR2MzK2hQ?=
 =?utf-8?B?L2ZsQmZBZ2RXNktaLzJSS0hhaDRsUHN6Z3RCVDVGd1ZEWWVaOFJac0NXZFJQ?=
 =?utf-8?B?S2wzaEpsUGFLZ0VLRkZGKytyNjduNWEvdlNhaDV5S2IwOCtQK1JTSnRyVUo5?=
 =?utf-8?B?UWpZRjhWZStQYlM1REJJNUpncVdUeXpHWFB6M0tYVkx0bkxpS0QzMUxhQjFO?=
 =?utf-8?B?RUE5OXNsMGNGSm1TS3hhS3d2U080eWRPM3VLd0o4c0JiQzM5WStRdnl5bE54?=
 =?utf-8?B?ZlZHRzRqZlE1UTF4Zms1RkFRVEljK1dMMjVDdlI4eDV1ZXZacEVXSndvdUNh?=
 =?utf-8?B?R3AzUnptVW5WR2dmclgvL2pnejRXNzdSeUFUSWU2NGpGMitXeHZjVlVIRHhr?=
 =?utf-8?B?UVhtckVkYUFmMW0wY1F6NHgrcXliVy9KZXRrVm15ZEdNdEZWaWwzbTQ1cVo2?=
 =?utf-8?B?aDEwc3RFNktEQ2lWT1hidm1EUlIvSW9rMkxaeW9rQlR2K1F4bWlteE5EMTVV?=
 =?utf-8?B?aTJvdnVoTTBzTzJkTG5jZkpSUStrelRKcUs5c3poK0sxNWtDMEhlSkE5aWxG?=
 =?utf-8?B?MG9sRGl6TlRScjBaVEJYZUpxQ016WUtMUTJtRkgzenpjbldiUXJGYmdnWGkx?=
 =?utf-8?B?N2MyZyt4MVZYUnlHYml1R2RSUFRONnQzZ09ocDNNbG9zdy9GREdmV0ZqNjN1?=
 =?utf-8?B?WlprRmRGazZCTTRta1BvTnljZmNSSUFzbUcyRGRsbHF1bmY0RFVONTNCQTlC?=
 =?utf-8?B?T3pTVVVNNmdmeXY0cFAxNnh2YVJZemZRM3NmTGRnUDJWVVl0dmJuVk9YK2pv?=
 =?utf-8?B?Z0duRnVrUjRaalRoeVNPVVpVdExiWWlzNEFZZjhvWjcxWGE2L25CNUY5NnBo?=
 =?utf-8?B?QnpOZVdtUlFSdk9vbWI4Y2ZEOEYyUm9EK2JPTmEzL2NVeWFNeTB1Zz09?=
X-Exchange-RoutingPolicyChecked:
	hePfhBfvznB42YRCdJCN7rUYTRsm09rrunmGRbXRxL2FnlFaRu980h3BGqCLKw6r45v3skltF9YjN4trmAsKeysquiasrSegABguCxAhC3goqs4n/GmZSsEEGVlUYMEAvfk15E1NJ9fdBbgzK7kwmnaVmcRN9F9rVKwMYhNYHWnhK5NnZAEaD4+aZ+nyK8t3Z/NIVJOtZO+e+7jN6O+aIaVLxI8vM0XIDP3Vg42IyPm/O37fra14JyICOdO8xkD4a4dyB2GsovIZU8w48Pjo7xZeOBv1Sv6Af283BEui/H55eNtEW+XwFesvVTkA+pL6Cner5oAQFY6yA3F02f5TGA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dca57e-eda9-4f7b-1298-08deebcf6ce8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 11:08:45.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqGt4D3RBtJLB9gMT8PZp+fEhVTquKZ7bizIzaUiJWhd4GSjZiI2t+ijy2jCsEK0dzbLBirX93YR36AuQvFWGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8296
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwOSBTYWx0ZWRfXwNnQ/dv+lAJ1
 dRArtiED65YGTKupVT/MnX+H09CR+Mt+jYEpTMXRnnmYsQ1Yqm/AMX0qlUwliW4xzFF5qIuV1UA
 vzEPO2G3iQ82YLJ72esjxsd7PNJxAWbNSDjdgo1GcV6cuwCqcQNJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwOSBTYWx0ZWRfX72e3Ko3uIaDV
 C8sHH51Qm9wh0QFeP2yblDPUOhcWsRMdbKvQ0HLMjs5e5fRFJAES3oFypjJhM/JoP7rBw+mMAMT
 gqFFvHEKphR2suitxlFD0ESmt9PAdsXOqt2gCcHGhqmbst1BH9Ehr3PN/Shys1e/QOFGmaKQid6
 SJFvMC+SRp7O1w5dnL3rjOagpPvRZ0TeJXyHPBFrCyrx4AT07v9nCwBS90A9TOgB7FVhCZre4PF
 cJu2mhIPgr0i+ioYxbSrXJFyv4zOiIAHF/f+e1SjCRsPkVgXoVzxf7fuOsSOTIvtUlSqoakkv0X
 IAfL7CDmsbtBsnQVpUv7tNY8WqhZqAKb1xPUDhDMsjKPwjJjtHm4Zsb3peheGVyGStpfl6TM9T0
 rOP5a1/BF0OpE1elsitSf/9uHvgLBu1zjXKiQHbwLYll38+Nlb958FpVg9wcWiBXFWx24jex30w
 6i2aZnWn7JjJZs+KtJg==
X-Proofpoint-GUID: bO6REgNVPePIAxR6jQXkOmbwgyi30Scx
X-Authority-Analysis: v=2.4 cv=M7x97Sws c=1 sm=1 tr=0 ts=6a673c41 cx=c_pps
 a=94FLU6K3oGZrB1XHaeOsDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=t7CeM3EgAAAA:8 a=ItJTzpOEGVJJb3sOj5sA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: bO6REgNVPePIAxR6jQXkOmbwgyi30Scx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270109

On 7/27/26 18:03, David Howells wrote:
> Yun Zhou <yun.zhou@windriver.com> wrote:
> 
>> rolling_buffer_init() uses plain GFP_NOFS for its folio_queue allocation.
>> In the writeback path this can fail and trigger WARN_ON_ONCE(folio != NULL)
>> in netfs_writepages() when writeback_iter() returns additional dirty folios
>> left unhandled.
>>
>> Writeback must not fail with -ENOMEM. Fix this by adding a gfp_t parameter
>> to rolling_buffer_init() and passing GFP_NOFS | __GFP_NOFAIL from the
>> writeback path, ensuring the allocation always succeeds. Read paths
>> continue to use plain GFP_NOFS.
> 
> I don't think this is the correct solution.  I think you're right that a gfp_t
> needs to be passed into rolling_buffer*(), but I think we need a mempool as
> well.
> 
> I have most of the patch for that, but I think I need adjust things so that
> the read path uses GFP_KERNEL, not GFP_NOFS.
> 

Got it. Your mempool approach looks good. Please let me know if you need 
anything from me.

BR,
Yun
