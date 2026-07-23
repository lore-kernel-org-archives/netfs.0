Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6431A555
	for <netfs@lists.linux.dev>; Thu, 23 Jul 2026 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778263; cv=fail; b=qUDLs8pmn7/lx79suLUosRvLHVV7H4R7dg5OmZsvbBVNcsl3AieZukHJ6jBjeKUAAzCBTWs9zuwx1FManxfk9H0NlbbJr1fplf0+0qGLx3A44Wil53POxhz/rP74Y1nQCZtCfIR6ICdjfEq0S6VxkVH4f8DXufQhZQ7Yf7h/kHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778263; c=relaxed/simple;
	bh=TtEpF0pvPT9nNDF8yE1cqCUusZa1czJE6aA2JYRR8mI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqPdTsaxqo7Td+YDBup5zMFHa/iXFTio3aAjoezfhs4phymtx1R8wO+i96x5lRslHkohZVLOZjREJIDVP/sxUtf3CNkKrenzzegeKBOB802+wxFHpX6tzoZfuqoELtyX1RyLIz/x3RUHVeFuayp54d+xPFWdzIc1I0VH1AR71Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=MYtbSDLh; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="MYtbSDLh"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N3EOKC2427955;
	Wed, 22 Jul 2026 20:43:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=O0cRD9oSdOK+xqFfC3aZD3sys6U5KhdmgfnTLZgqG0Q=; b=
	MYtbSDLhbl9jEPPfxjUzs05yizLHNYQNDGv3EbqPe894YE9yZZvIowYh4mFGWWZa
	l1UhrL13rXd6jIn0TeFG/aWAQl2lvim2H3RDUPimpU67NJk6r+B9EvGUPgmScRxb
	RYPpOwYX4R7X2hnWdD1BN8do7SzzoS8quvqXFSvnw3AuVG1saMeSCvQfugKhquqk
	O4XOWWk/c/1ev5IBGzaNlO0z5orpG/6eCFvvb9bhC1r7+iDxIb0ffiN4v2ZHMP0i
	5BjRQ4vlZ7p2iVoYXjDirX4eGcifduc3GL+QBk6GsGzxU8croWhU2horjeYGuUBo
	tVPUi5DyV3DvT1G/T+g0kw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fjt3u22bd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 20:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sN/Xme0/Hr5aBT4k1X+66IJOTfn3qjeJgVn0MSre/kDFr6kGYuCB1sz2/t18BTgt5+oDoYCMPzbs16lep8FzTYacRNFohFOSmhlHtyhrdX4kJ8JTkgIzhU2/Lu4q6Hc7K6iKigtwPMPg9WqPdUfHhq50/Cc+83rNE64iofukEJYYdNz+yx0qS4CyWc3LWsSH8kEcL6CFqjm6Bk1UhqNkDmQZTrjFzpkhd93n9ICsC9LursPUhKBNCvNtjreBefNsMjyMQDyqnuuO+AJeu7kw7Xwu9WEvwQxTTlbqKOjRaSoNyl0NgNX2D+sa/DkmZsoV2U+e+GmtKvbjWndHOq9iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0cRD9oSdOK+xqFfC3aZD3sys6U5KhdmgfnTLZgqG0Q=;
 b=UQRjCqlrs4AZxeAVvESsxtg1exxyy2v+buB3oK6pLSYBCVwtJSQih8hGmK5HTQfVItYGD0G9ygaCBZV7ICYqytZNaCCUrxQF9sU8oECNM7rLReYNFD++gybqkzvFCYJajXGrlZ9XfbYVmUm6S/Tf4MffCi8TFrnhYR6KH13S5m+YQIh2QP9swvPitQfKM40mPvaBFo4rwcMuUhbrsatMkDW6A6tPFtHdAy6hheyk+WP1rJkp2MQZ82qopGGgWE0YsKDIasVEGpSpJQNtZ6tCr/17+XfXleUzHgP9UrkUxXU+0FjyQXqZ8yTatMa0wAJwOZXalLT87GVdL73gkMQz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by SJ0PR11MB5917.namprd11.prod.outlook.com (2603:10b6:a03:42b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 03:43:54 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 03:43:54 +0000
Message-ID: <6c295e86-4499-474c-9806-c8ec2d7af745@windriver.com>
Date: Thu, 23 Jul 2026 11:43:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Is writeback_iter() missing some error handling? -- was Re:
 [PATCH] netfs: fix ENOMEM handling in netfs_writepages() to drain all dirty
 folios
To: David Howells <dhowells@redhat.com>, Matthew Wilcox
 <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Cc: pc@manguebit.org, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260707052555.2055002-1-yun.zhou@windriver.com>
 <82546.1784729043@warthog.procyon.org.uk>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <82546.1784729043@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::12) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|SJ0PR11MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dc066d-e707-4be2-b3d8-08dee86c9e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|5023799004|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9kCpxEEO7qjy6LdTu20tYhRS1oIHuCzNEEHbLLefqaz86xGquU4XZq/77P87CVYOqrksi7UicKTfKvb9AsA4BrkNHM1EWefd1jZ7RFXwno/KmWLnLOSN+dmZSYNttmEqKiMpoEtpFRaVv7B9pKnKYinXBX9mDCTjXZirvzkjsJAfIO3DThbij6G4FiLEqEqIo482qmrSAtaOFUkHxzU6pEl59O33KxyeKGPBQSBbu0tBTL0G3QKlOWmxyocYqBYBDdgCgSPO1UzYQmC6awe/n3o/60U9WJffCliBfQFrfeofLVvJgnWuvSvAkmYIRIr3fFPD6m3EqhqhtNdzu3vlywf+2ttJ3pxR0yv+dgOOlhjmsCYbaUc14ppK/nm4P3LLrwbq6wjpVs6GuTj9TM8uByWlTC9RVtF+CBLdDtNhoE9E0XwKE8mtXgmOAWWZoGfUCrpk/k6wobYwRwO6NNuFqMHBwzPPy14nJqFIv51E67AXioDvMv1ijiN3mXIRjKQjy1zRdMLKHwmqIhR+Aff7CyEzW6ftgGWQdhEHZTb89L5opiMKbYR6IfkgGItHbxHw1DTyS4fLV/y2TjS9b0FFHNiwhADiWzrZz3yi0NP5FnNDMMtffQZtpVooqZ+KbqwaccYUkXf9OsumfuACSvi2V12ro56dwW/ehLNjrGcKwaI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjdDK2FCblE3MGpqT2xUWEpEcUMxUUtiTFgzdzlCbWUxd1lNKzBoTWFmaFBC?=
 =?utf-8?B?aGlkbzh4K0QwVUhHeTN3eVZQNWlhNWdYU0VjU0VUTXlZT3BVU2k3OHorTWhh?=
 =?utf-8?B?TmpsWlVIbHRaVGFMT1AwbE1zNmU4TkhxTXlYRHdCZU9UeU5qeGx0NElWVjRI?=
 =?utf-8?B?UC9XQ1FkYVhkc1dWa09MOTVMckxpUnpuaE9VUFBBcVFteDROQWJKelVGUFgy?=
 =?utf-8?B?T0krMUFFK1pGZW9DV0E4Tk9ybEZrWDR1WmdmUlRqMk1JVDJDeEhhTEhFRzNs?=
 =?utf-8?B?MTQ4ZVIvZm13M3VUcEN2RGJ4TWFPS3dQV1ZVYzJoRUFiRnNSTW44ZFhlSjl2?=
 =?utf-8?B?dDNmc3RWeUZBUFVIWDZzdkljd2wyL2J4dWExelZFVHVYdHRmNGNFeTBpam1z?=
 =?utf-8?B?bjlUZjU5ZEhCUHV5YkJWTTA2YXVha01FRTJxVlo1d1YxMG9hVytlUGFqOTEy?=
 =?utf-8?B?dm9XQmFqN1JzSFpNamtnZzVLalJCMHFKNkQ3cUNaSXNkWVBjcXl4WnBXeEwx?=
 =?utf-8?B?RmNYV2dZakJGTGwrWGZja2tZazVmVVMwSlVXcXZRc0NsUHNoMkxqR2pPMzFr?=
 =?utf-8?B?YnE0VlcvL1BsczFLV3k5V3dZYy9BODcrWWVZUWpFRnJWbkUzMUw0S1FqRXpr?=
 =?utf-8?B?b0NtSlM1emFEbVhsWW1VMVgrT2EvZVpBQkM5OXN5K2RGRDFHS2RmdmMxOU1K?=
 =?utf-8?B?eXMvU0dqZFVKKzI1bGhyM2Qvam05bHN6QVNTNHZKbG5ndEtsOEttTmUxUitj?=
 =?utf-8?B?Z2hPclVaOXpRTi9FVTRNVWRBT1FJVGVuS3piT2tTcjllYzZvUyswRkF1bUxJ?=
 =?utf-8?B?YlZ0Z3k2YUNnVDN4UEhQaWx6VGdNUlZ4SjllTmVXUytuTGRkVFdYYlQrd1o0?=
 =?utf-8?B?U2NvMDhzRTh2Yk9GKzZDQjgweERKQ1pTMjFhOWVqc3FtZVVmMUJYQVA4RXVa?=
 =?utf-8?B?RlVCQkNYd3JIZTU5cHV5MlBmZjRxRnFlUUZtWkZNRTYxTm5IZGhjbVpaSnl3?=
 =?utf-8?B?d2ppSTQ1ZTlXK3BPL2gvWWxibXhUaFhxZ2M2c3habHFYRXdFSzFuUjJkdFE2?=
 =?utf-8?B?UnBUZ21QbDhXa3NHN3VobHZXOCtjbmZlNXNzMmhqUW5YcE9qV3hZY29ZWVRS?=
 =?utf-8?B?ek1GbEYyM1dma2dtMmVzbkNqbTZWWlJXOWc5Vk1WMzVKcjlNb1lIYnhUeWpr?=
 =?utf-8?B?R2ZudncrQjk4QmROTEpybHlnZFAwYm5NdWN4bWxwb0YxdjZaWUY4NzQ4c1dE?=
 =?utf-8?B?N1B1cEwxamU2ZXQ1cnA2TXpQR3hnR1lSelJmaGkra2Z1OHZoMnBMRmNIVWth?=
 =?utf-8?B?SjR4YVFaNUVackNoU1Y4SUVLay91UkhUODB3eU1QRmhVNVhRY1h0RzAybFFQ?=
 =?utf-8?B?M2tVWm1YMTM3YlRFTmNPbnRlVzRmS2tjREhaT2QwcEVycng4SndpOTJVUUhI?=
 =?utf-8?B?WloxdnNYRHIvcnRWZisyc01Sd25jbVozanJwVzFkSVRGUGQ1L0xYNFFtdm45?=
 =?utf-8?B?ZlFRQ00wUEg5UG5RQUFjcHRVNnZaTVB0a0JXUEk2Y1NORk1kb28zQkZJWmVt?=
 =?utf-8?B?NlNsSE9jUzBkZm93bTNVTzBkNkVWZUZvdlBqNWtLZ042YmMwMGFaQ0tKRlQ5?=
 =?utf-8?B?SzZUUTZ3RVdDVDVKYk5uY1N1R082b29BZWx5ZFpCa0dHT3NRYityQUJGa01v?=
 =?utf-8?B?aUJhZW9DM0tYSFJxTDNLQnovTFdLcHhMZVMwd2NzaXFueVpOemdTWEc5bEx0?=
 =?utf-8?B?TDhZOU1zWFB5a0hDeXBwSlYvSXhhK1pGSkRmNEdhS0M2eDVJd1FCcG4vcytu?=
 =?utf-8?B?d0ZVdXdvVWVNQk1JZU0yRFg4UjkzVmNFamRYM0dVcjRNWklOeGtCMUFzU3RO?=
 =?utf-8?B?ZVdqeFlrOGhlZG5XV1NDOGxjeG9PMlpCSWN6Lzc5QVVRemppMnhVZjRLRXRk?=
 =?utf-8?B?Tyt5cFlZTWRtRXVSalduejVQUmtueUJRYkR5Z3VEdUhEeGJNaWRkMlJPZ3lE?=
 =?utf-8?B?YnNSRUhzbGJkSmx1Zy9YM2hKZ2hZdTZscW9nTG9RcERoTGQ4RkJERmpDMTFS?=
 =?utf-8?B?bWxjS2hZc3FnZG5JN21VaWZOMFp1YWF5b1VHV0srSzJtcExXa2Q5WHdmS2RJ?=
 =?utf-8?B?OU55cnJFUlhPaWVsK2kvaUFxN3FDUWVNMTVySkpoWExYM2Jla2wvMnNDYTcr?=
 =?utf-8?B?bUdkdnlIQ1hXbFhudzhITk1xZ0xTYlR0SktmSDNWR1FwVWNDelUyK1ZyUmV3?=
 =?utf-8?B?MXRDQkd1ejlIbzVWTjMzamxNRUJjMU5BOXVoTnZKcGVFamlKbGRBWlVqVVVi?=
 =?utf-8?B?RUgyR1FBV1pSdWdUR0xpVkFieVpQRTc3WUpCS1N0aXRKTXM0d0JJUT09?=
X-Exchange-RoutingPolicyChecked:
	gSJYmBMKUKCC3J9+NZKa6y6bC5KjsEZErKoZUC1Hv6VUmIe3g4Hy1zJ6ioKF05FzVYGCotcYSXdXpTH2X5N0mX3Gid1n+bu3+m6/BNJtGq4F5Q2yrbomWCzqeIyvcS7aMyi2UYazlP+THAKfgeaqKm8I+OdJeK22gBR1b8/0MIdAEI7Pn0F/gBd2oHo0RwOpgHWCw/L0GEOz9BIGto3yHXamIeuAK+fJioCl2RP8MnKziMgQbioZ2cOUXALRBRPCPwz0wxqd3UCt1ZMXU3/3xywp3BghcZz412o0iVdSmpOeGg3Nysxpq6dr9CT3itNXhL+0IbNR39N42O+ngF0kQA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dc066d-e707-4be2-b3d8-08dee86c9e46
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 03:43:54.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoQtd0cYM0jREAnwbkbMISQQBoBgoyC+ZIMTXszIxlzJPAVnLVxm5IE7mzVT7oggd9POjwVpq5BQjO/eGIapLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5917
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDAzNCBTYWx0ZWRfX4LOjb0VzOd7G
 RawZSK4IWbCWLHi5ITf2xqmfRmOH8R84lMOuHtRzX9+j+H4guf7uTdlJNCRV/f9IZPlFOx2TBt0
 cg8nvM0vLgu0GPz23VNlG3FM+rgNdtgBMYnUkodgUPrmipEOWrDTL9tUCqznk4A/Ib7ilJ2Ayv9
 AfkDwCgl1aVK/8+wpPeG6xWgYHar+EwXMIWDOHmqjWBanQOZ2VXvNo9xoe1zKvNBywJ030LYVwC
 gw258eWJCCYCjP8wlHFcVQCEoLebn3tVgPDTN0ke92V5T85CqWoHlKH5u3jmCUo59VhDsMImoRj
 zfKrC8Xfe0V2xbEk77K/5FyodE93KGwZU3gQCtu5in5OAqhvJHe457CWL6HhFrXwfgjB/XPN9rz
 eiaV148nKr0nFrkcE1BNSNhycqUVpPR+sVVcMBD8jz8uemRtkbS18mqGU/kq2NrL3E4TwB9BDnW
 FxwizAp0PfvEB7Mx+8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDAzNCBTYWx0ZWRfX7oEYIoq08oia
 UiSRr2eM0xcWRFscRwRKJ0IyJ0TrfkWOahxTT4oSIoRaRunQfUvNVgB7V/FLQmUfHrneniYOnzi
 o3YEco4kBEets2qspqejhx6kBm2nIPWyBchbkX44AQ+ZtDhaDTNp
X-Proofpoint-GUID: hu797o888nsB5AphqLRe9oz-LV_KUbRN
X-Authority-Analysis: v=2.4 cv=U9yiy+ru c=1 sm=1 tr=0 ts=6a618dff cx=c_pps
 a=8LlSNZ/L86USH+wcAhsXzg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=t7CeM3EgAAAA:8 a=XvCxoO8_HWru2NJsgFUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: hu797o888nsB5AphqLRe9oz-LV_KUbRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230034

On 7/22/26 22:04, David Howells wrote:
> Yun Zhou <yun.zhou@windriver.com> wrote:
> 
>>   couldnt_start:
>>        if (error == -ENOMEM) {
>> -             folio_redirty_for_writepage(wbc, folio);
>> -             folio_unlock(folio);
>> -             folio = writeback_iter(mapping, wbc, folio, &error);
>> -             WARN_ON_ONCE(folio != NULL);
>> +             /* Redirty all dirty folios and let writeback retry later. */
>> +             do {
>> +                     folio_redirty_for_writepage(wbc, folio);
>> +                     folio_unlock(folio);
>> +             } while ((folio = writeback_iter(mapping, wbc, folio, &error)));
>>        } else {
>>                netfs_kill_dirty_pages(mapping, wbc, folio);
>>        }
> 
> This seems like the wrong thing to do - or, at least, a bug in the
> writeback_iter() API.  Getting something like ENOMEM would seem to indicate
> that all subsequent writeback_iter() calls in this loop are pointless as it
> looks like the sequence will just go { lock, undirty, dirty, unlock } for each
> folio.
> 

Thanks for the feedback. I understand the concern — the loop is indeed 
doing mechanical { redirty, unlock } work that ideally writeback_iter() 
could handle internally when the caller has nothing meaningful to do 
with the folios.

However, given the current writeback_iter() API contract ("callers must 
keep calling until it returns NULL"), I'm not sure there's a cleaner way 
to handle this without a VFS/mm level change. And in the meantime, 
syzbot is hitting this — the WARN fires and any folio returned beyond 
the first is left locked.

Would it be acceptable to keep this as a minimal stopgap fix for the 
immediate bug, with the understanding that it can be cleaned up later if 
writeback_iter() gains an early-abort mechanism? Happy to adjust the 
approach if you have something else in mind.

BR,
Yun
