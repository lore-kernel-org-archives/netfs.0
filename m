Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1513911B2
	for <netfs@lists.linux.dev>; Fri, 17 Jul 2026 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281174; cv=none; b=qMwdRYLB+ek5SiQr/3ZE4HC4w9Ep4+8LIdKG0WBwh5i79UkPc4Ku4MfCBVMtJHBNMxLkKuGyhkc5bk9RyW/PvEOGWLbKyPDfEh0jYNtOPVIXaddmKXpims71knzhDNb/h5Lm3piGzC5rS2QMtF8h21Wgxysxqqnlrd/gWu743/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281174; c=relaxed/simple;
	bh=Hg8Ik6O7MXHToPiVA3SP1P2PwVngeLSTsw3jWC16c7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lg0LEPETLPL+aSLGuW0h+z9C69O1ZEbj/WcQ/bBIUmbC8LOXlJVYOsoJlg/rWvYpi4yoMQXWkp1ubUlZ9z9b4cEYiewTlAMr8bzq78efNOKzn3Zq7yqyCgGnQzR4Cp2sSu5gpxZxLB10wGXt4q8PpTPAnkc91U4ocpj/ULOCvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xWBHAu1v; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xWBHAu1v"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784281163; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DybOtkksmCbT95n35iBGzzDyyyVg9ewaf0ZBGdB/vUg=;
	b=xWBHAu1vt0uu0/jtC36whnguit8jix+IqvBscRDO/peJK5kqY5dNF8JETo0Ju0DC8x2FvuaRXAQup0UWDRabWSg4N1p91ZjdhksTCJWSup/3V2UZzrRHoFGxL/SMrDc4m2d3PPmYpDCp2SkuTSgG2PMiC4BXTv9DLBcUHIRE3UM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X7GwzAY_1784281160;
Received: from 30.221.133.5(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X7GwzAY_1784281160 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jul 2026 17:39:21 +0800
Message-ID: <4e05b351-429c-4d48-8858-34593e5b97e3@linux.alibaba.com>
Date: Fri, 17 Jul 2026 17:39:18 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles,netfs: sunset ondemand mode
To: David Howells <dhowells@redhat.com>, Gao Xiang <xiang@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Christian Brauner
 <brauner@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Jingbo Xu <jefflexu@linux.alibaba.com>
References: <20260706030439.14212-1-xiang@kernel.org>
 <3594659.1784280434@warthog.procyon.org.uk>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3594659.1784280434@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 2026/7/17 17:27, David Howells wrote:
> There are a number of mostly minor issues with this patch, as can be found
> listed here by Sashiko:
> 
> 	https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40redhat.com
> 
> I've fixed them up in my tree and they'll appear in v7 of my "netfs: Keep
> track of folios in a segmented bio_vec[] chain" patches.

Sashiko's report on this individual patch is:
https://sashiko.dev/#/patchset/20260706030439.14212-1-xiang%40kernel.org

I once thought it'd be better to be the first patch if
you'd like to apply to the netfs series, but anyway, you
could adapt this patch if needed, and thanks for carrying
this.

Thanks,
Gao Xiang

> 
> David
> 
> 

