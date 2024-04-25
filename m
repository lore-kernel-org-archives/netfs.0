Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3812B7D
	for <netfs@lists.linux.dev>; Thu, 25 Apr 2024 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014819; cv=none; b=nOUCb/sMZWLHv7eSysuP5gQxrP8bYKGJlur8vVjq1aXyx20UR+jfpmiB7xVYPPhM4rx0ar2jcDK8N6nEaLzk/AxmUEwgfCh/VZJZJP3ZwXn5pBCp2p7GVBcGBp1Qo8Ci8ZpC9DZLaz/CXFwBk3LRuGyK+1z3rmBIYHlbJiNhj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014819; c=relaxed/simple;
	bh=F/1VMu7Ncu+E5GMEYHg5FIcaKmH6+lOLwTRFwG32kF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeD9Z5f7tvWOPBOexr3BsdFdtGFHlIAHrM0xnTZpysqmnP+XLV2y4Rj7NOPrC7m9d35Ym0G+zfFEiwVXinCRJgD1BnpHGkxACZy10lTpg2jZKyp9SBLoS/HrwyUyqPTbGjNfG6OhDAWqA5Kz2OE2+YDfMLt0QeesUbrFuqlehaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y3LdwhCn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y3LdwhCn"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2af800ff18dso482173a91.1
        for <netfs@lists.linux.dev>; Wed, 24 Apr 2024 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714014817; x=1714619617; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45q2opjjuUYEePVm3ifdMLHGn3JYGUOldjvko9Req9k=;
        b=Y3LdwhCnR2D+U4A/u+B2wHxbpLkxqnshl5ZvyZSOxxCCWrmVbsHCjSaZrxTAT44XEr
         57DzbkvjH1nOw1kwzEzZ1+/qgSSMdGfHLcug7NSQrD2TkBxTX7Ilpvl/z4S7lwma32qN
         fEmFCkacNwkXz3lOGJWP1nOhvou+iR812b/nCVBKoXgRQPBI2t/Awuvlp9Kup3LWTyhi
         2cgKjG2k+klLLg7B1t1S5EvsMYXaknL5ZRY25XLzzJjqt54dgq79yP/428H4ieE+QUwj
         iv7hrU4zzrO9/UJcBL/XBv5nIAhg1hp+TBNTxFOyrVFomOB5X8io7UjO+cCT6oUBohpi
         FjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014817; x=1714619617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=45q2opjjuUYEePVm3ifdMLHGn3JYGUOldjvko9Req9k=;
        b=OPbvp7/lQKMYsjJ8eY5TEQau4iVzOVslTP1x376ehQwEtKEOGdRi+hnneac+/FWpYK
         BP/oqFX69wKv72QQzNDaF2XYm4ynluNOYDPYdq/GsOfdVTih3T5pvZ+YEckE6Z/vOMVT
         acWdKw+9seJDkYJ//z8stPS5tZJjsnSjbMKPAleyworXQDEly5diOypbvsCrJJdHpzxs
         QbDri7iVuB/qN4XYZqutSK560tNwdsbld0L+pc2wN1oVwriaLBDltRJZiMvfrOP0l0wx
         ue+YEjsjB0WrkEGSIPSgLZ0omYWSYnvBF16i/8Xt76SrxYlAmUAttPx2Sr72v5mbEbvj
         p+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd74RAVTsKHUCNDv0NHYDFwrLYfpaAWZ/paI7ZV7/5xcaC8FHyrGnSNrWFfiPA3Rhw94M/wfXkaGHBTJAcab2sogkr6+w=
X-Gm-Message-State: AOJu0YxmiRLG5Y7U3IPj+PBuXk5lPt6JQ4oFBGg7OFmSybxAkiN4RxO9
	5WtniQxqOc8mPPJADQtET6ysFEw9JOV8E46a8xnaNGul+6951mSjEPkEGImZmHw=
X-Google-Smtp-Source: AGHT+IEuq2nC3+NrQjBJkDqAEPYGH85KMdEqJehJWR0o0NQ3qmkCAsRYPwQPdvh8mGs6423pdhVCfA==
X-Received: by 2002:a17:90a:6b47:b0:2ad:6294:7112 with SMTP id x7-20020a17090a6b4700b002ad62947112mr4177222pjl.14.1714014817331;
        Wed, 24 Apr 2024 20:13:37 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id gk1-20020a17090b118100b002a5290ad3d4sm11981013pjb.3.2024.04.24.20.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 20:13:36 -0700 (PDT)
Message-ID: <6c04aab1-44d7-464c-8080-b06d5c0f16ee@bytedance.com>
Date: Thu, 25 Apr 2024 11:13:30 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] cachefiles: remove request from xarry during flush
 requests
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 zhujia.zj@bytedance.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-2-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-2-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This prevents concurrency from causing access to a freed req.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/daemon.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..ccb7b707ea4b 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
>   	xa_for_each(xa, index, req) {
>   		req->error = -EIO;
>   		complete(&req->done);
> +		__xa_erase(xa, index);
>   	}
>   	xa_unlock(xa);
>   
