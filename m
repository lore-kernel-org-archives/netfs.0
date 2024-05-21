Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFA7F48D
	for <netfs@lists.linux.dev>; Tue, 21 May 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306759; cv=none; b=hntOS8VA8GIiX0vlgd8WF6XR3gfxUGPOFk6++6OvwTVLPCdqMEeKPtc1KMbHQ73FGaNlwrkJyZLn4zxXXq+NpBNYWB+5usTpsYUNNmynYqr6wrt/wewiFpKZUUPaoNZ6yHyL+S6kXMset5q47h2zdT9pLEf9PWXfC8DhC03PBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306759; c=relaxed/simple;
	bh=ydWfB8Ixx2WGgADol03f1VZf4M7vv9stY1thXdwwiug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZpKmGTvTbSBdVkF9lXGdjPwW3zvUkO0HMqzALYTcQXqUjnRMtPfs1k0GQCCpvEJGjERMv7v9ZXiNnOrHZ4+cvJ2mtvByRrXcK7mXnZCNaNvzzqYictPw8/tzbzaV1J3eQhEZlRytPjA+/xYoeolHk3kU0KIQWGEB9oxgsB60yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k4ZIiSUL; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k4ZIiSUL"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36c84c95c23so1467305ab.2
        for <netfs@lists.linux.dev>; Tue, 21 May 2024 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716306755; x=1716911555; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lu6Cz3W/7JBafbJfSPoliRhPwzKJFkEKd4ea8AjEFNM=;
        b=k4ZIiSULDMD6dhDd6lQcudyCTUX7oMvR2I04EucM/WBogsc3Q0I/31+QI4OebAc0Dl
         xswcq5zfaFEYqndLGlbpV/2lFESGiRbKndNl70ZQcFQ7vmBWGwZ091Z1Ci7q+Zo3KlS8
         HUM+5OnaVyvrvGvLMC3xdr63eCd0Yrio+pXYEAexLiuOryWQHRKi1k1tKM0mGd2Aa6IF
         OQ+B9io8eiUVFHoghTJeC0gTxgu6f9jk20jfdTNvVf2XlbVLxvs1PF9/KYrDIw0S4O4A
         BNO30UUKKNA3lAA2n63AHv6zY9pXV6K6Ryu9vWoqOM3J4Ll5yg9F4EtYE4umznEPV3Rt
         juJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306755; x=1716911555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lu6Cz3W/7JBafbJfSPoliRhPwzKJFkEKd4ea8AjEFNM=;
        b=OtlrD6P3HhXtvJpY0Q67GCDOBX4OnzJV3R1y74Z/qz81Qnk/ae49Bv0ijTzZ33ENXd
         eS7i0porUsc2YNBijIkMhmnopUfoxuXONGKZbVWqO2V7eraDuMf8H5zEdv/ipyynEsCo
         A6+EhH5qrDmlBghcUjMs/hIuxLFdLXyOITItti1fLBTjHlqf5ZaKXEM7+yODC01UJl2V
         VkbsMDw7zRjqmGLDPYYTOiDt90YZT7G76iBDMVwc1a7tIr47uDI4zhHnC+Iaac+8RIZk
         GJTLNWqQTi7awnd8D+4VU7A03tjEHmSVgqM5itgvR0CnTf4YZXWlPwLGP4I8nhcnz0Ll
         T/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCV9Scwzl5aPQWWELbYjPsoMJ9sKthXEYG6+iiwDMDRLMYSrdZHzivGtTYq/iyFO2ExXg3RrK6yUejqt42iqEHbhkVLwEoY=
X-Gm-Message-State: AOJu0YywYwvgg9//8qaLyyms46YeR5I/++P97u2xebk5tEm8NLeN1ahi
	XV2kznPJXTBovT3ollK7NzBtwko4Fi6eJ50CPFSwVKiXoIqcsEmcqcAmJkKH1VQ=
X-Google-Smtp-Source: AGHT+IHa1zyl6cmZPdjySIykg2SQdYZupp88XF9rpgThrnqOxMjg4dDFQSMzR/ggbhek66vW9xxDQg==
X-Received: by 2002:a92:c988:0:b0:36c:c86b:9181 with SMTP id e9e14a558f8ab-36cc86b9470mr305103065ab.0.1716306754979;
        Tue, 21 May 2024 08:52:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9e1363esm63659975ab.71.2024.05.21.08.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:52:34 -0700 (PDT)
Message-ID: <2e73c659-06a3-426c-99c0-eff896eb2323@kernel.dk>
Date: Tue, 21 May 2024 09:52:32 -0600
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Cc: Jeff Layton <jlayton@kernel.org>, Enzo Matsumiya <ematsumiya@suse.de>,
 Matthew Wilcox <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, netfs@lists.linux.dev, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <316306.1716306586@warthog.procyon.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <316306.1716306586@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 9:49 AM, David Howells wrote:
> Fix netfs_perform_write() to set BDP_ASYNC if IOCB_NOWAIT is set rather
> than if IOCB_SYNC is not set.  It reflects asynchronicity in the sense of
> not waiting rather than synchronicity in the sense of not returning until
> the op is complete.
> 
> Without this, generic/590 fails on cifs in strict caching mode with a
> complaint that one of the writes fails with EAGAIN.  The test can be
> distilled down to:
> 
>         mount -t cifs /my/share /mnt -ostuff
>         xfs_io -i -c 'falloc 0 8191M -c fsync -f /mnt/file
>         xfs_io -i -c 'pwrite -b 1M -W 0 8191M' /mnt/file

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

However, I'll note that BDP_ASYNC is horribly named, it should be
BDP_NOWAIT instead. But that's a separate thing, fix looks correct
as-is.

-- 
Jens Axboe

