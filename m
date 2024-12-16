Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C5202C50;
	Mon, 16 Dec 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344027; cv=none; b=vEDqcvJDlsPyp9lPViju7JQqI3IWDnknyzvdC6HN8s8d+kqACkff6DzW23zMR1vpnbjmSOHboydlhyld/DwTUpN6v+/IKfSDtCDbEucKsw8t1NHLsreOxKQoTQ+co/PIOKJNycgqQ6zWggvv0jnAbVF3RgMFwggOzKq9dsfDTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344027; c=relaxed/simple;
	bh=6o4jofo5o0s4egvVbxhwmAn4YH9WdHGRsBXLWeO+DtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMnR8KljF8w6xG07/IcGnkTvnqy9kQUQUmZAPaiuEIIdISxxdJdx0zuZuVOJksoXiwz/aX8BhGFkxJuiOvO/78VRhNv26rJLo3YyDKWXg+yB5M1g/VJ7Yf/Jo5Hfk2DRzex9EEad/Vfxw0ZAaCsVg748OWsvNQRYKbi8kIPk+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4waKHoL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4waKHoL"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72739105e02so4154808b3a.0;
        Mon, 16 Dec 2024 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344025; x=1734948825; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9ZM1VYLJhmWw0JXWXrNZw/asAR3qnp4u24wAg0Zo6s=;
        b=h4waKHoLQoC2cS0O8lap/ZS+CiHtnlTT8QDiT0spI0RD3wNILjyAukjPa+7Z4ypG/G
         mtBzETvq5qwDwiLlq0QLtJg+SX+8pt8xGOkvtkO+8KJK5zqq4jl+WFd2e7HF6+rKTjip
         jSHa2buhcTRkGjhiRhyGM/oX2MZ8QuKHNVFPL0sNH/YHZg5+SOUDxH7I3KQ06qsQGG41
         +j6kcbr9ZBkrF1E5Uf7u8yZWum2fpYuB7mqYS04e7G4Loh7IwwBw4PykHDFLFbLjfrjJ
         urU0IeBgGYcqrkj7SibLah4zNnsRimaIqDYs86r6yx3oFOJTnsiwGmWDGszMUqNG23Dy
         DynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344025; x=1734948825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9ZM1VYLJhmWw0JXWXrNZw/asAR3qnp4u24wAg0Zo6s=;
        b=bLuA1HbumNSUOvt7V+s8pge3MD+4facIlHJVv2s2Q/9lfOY1G//iRET84dUbdf7wVO
         bRTSf/yAlJisor1WhSJ5bXLrXGgBoFHwO7dXTcF5j6fOf/c4EdyawtuytrLZdbL+HBYn
         3dSnz+Kp6idAzW0ba3sS3DStVfTigXTCbS5RakqXOxcbPGCB53w0CLRVSd1+pQ15ZlXw
         vwKdtfVgZs2XvZ4tt3AZNvWW3YW4TxOaRmhd6CkDYtis0aCZw9va++iO2XyXOxoXFaDn
         OF1cENM9+T2jOVncip/IxZggKByAuWtIkgvVKYUJOGDy4epyoizGt5wvVOyA4r4z/RRv
         G4/g==
X-Forwarded-Encrypted: i=1; AJvYcCUcaJnOD7cOIfFQ8Vdz7ErbnQtSLLB/aaexkxSxhqAV3TaikcqS7SNb9w69J5ZUc6SP5TF+xw==@lists.linux.dev, AJvYcCWhL5v7n5PxJVuA2CuZt4ckBG/uIFhLL8SiSu6M3iaW8rQoEMWGBqJSPHp/K6C7boWhqkf9Sw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw78jKuFwGpTtHlyCKPVbX9adHTqFTtl7BfQL5h4X/6dFSQh/7H
	GldRK0Z1SiTvTqRg77572b1l+zZIGpkSmegg9ltKfFikZehpaxz+
X-Gm-Gg: ASbGncuCNmtifsqszcYRh/uB2lBAMqu0AUhdmH2dLtHgzaW8HxNO0fZ1jjg9qoUUT7D
	IdSugMWeWEzPpdVMob9ao17RxH3HUqRG+DfKJoohZrWQYRHu0rsQUYVJ9kgSlCsf7vOlSPc1xRR
	rFJcOze4ICgJp2Ohs/4IGPNC+aDRRDpWs1RwjXR3o1SthOmwcYbsAEel58HZ74AEivypX/KjQha
	K8Fta1tmKVt8SnWDlQtzHrc3abfPO7ftQuEjiopHkWAn0NIRBMAdOtXPQahj6agwa/PZMoZQjAI
	wEFAam4+1IoldVhS1lXAY18=
X-Google-Smtp-Source: AGHT+IFq3zJyvoXfAV7XVBdCiDQC4vaO/7xLrUwixiOvu21RBmLw5wfgxXzoYw8zU6Yia4k+KM7puQ==
X-Received: by 2002:a05:6a20:4304:b0:1e1:bdae:e045 with SMTP id adf61e73a8af0-1e1dfd91980mr18130458637.23.1734344023005;
        Mon, 16 Dec 2024 02:13:43 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bce39csm4517791b3a.189.2024.12.16.02.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:13:42 -0800 (PST)
Message-ID: <843f5270-d715-4c98-b191-1c271eb418c5@gmail.com>
Date: Mon, 16 Dec 2024 19:13:39 +0900
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] netfs: Remove redundant use of smp_rmb()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
Cc: Max Kellermann <max.kellermann@ionos.com>,
 Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>, Akira Yokosawa <akiyks@gmail.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
 <20241213135013.2964079-7-dhowells@redhat.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20241213135013.2964079-7-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

David Howells wrote:
> From: Zilin Guan <zilin@seu.edu.cn>
> 
> The function netfs_unbuffered_write_iter_locked() in
> fs/netfs/direct_write.c contains an unnecessary smp_rmb() call after
> wait_on_bit(). Since wait_on_bit() already incorporates a memory barrier
> that ensures the flag update is visible before the function returns, the
> smp_rmb() provides no additional benefit and incurs unnecessary overhead.
> 
> This patch removes the redundant barrier to simplify and optimize the code.
> 
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Akira Yokosawa <akiyks@gmail.com>

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/20241207021952.2978530-1-zilin@seu.edu.cn/
> ---
>  fs/netfs/direct_write.c | 1 -
>  1 file changed, 1 deletion(-)
> 

