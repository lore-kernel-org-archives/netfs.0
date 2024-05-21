Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9214831E
	for <netfs@lists.linux.dev>; Tue, 21 May 2024 20:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716322162; cv=none; b=Oujiyl8lWPJqqpvkxoSu95G7wTWKydwlRovCyVc8rrUD4aSxgEveFzwAkHEjYh6qYwrWgxYEiewi2co+KOipPRIMAXRDjNCPqcSYfU6jzI1LltFEb5lYxkfIVFu3ls74weHlC8cDMeY6PjxOEgfVanCC5qkpIyxKaAS0Xy53+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716322162; c=relaxed/simple;
	bh=Ia5u62ZgalmlFXflRn8jvvJ7YquyeyNuoWA9RxmS/I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ek2DJuz+QhRQLkVoOe+078Me3kSxwwhhqdhdd5Os0xoeMfMg+VhkjZtjYM1Qff2faAvZ92I5+RiCiAULvfAMxQ5eIIemRgMDGvztz1Xt6esa3aKQ106Rvdr5p1CkntpdLQlgMpRsBC2F7TvbHcM44EX+8nNXY4CFoNCGQZZUbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hqJwukLU; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hqJwukLU"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so2647325ab.3
        for <netfs@lists.linux.dev>; Tue, 21 May 2024 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716322159; x=1716926959; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWrpteYcdBNlx+6493QsXpUMihLRMiYDww87eKY9bg8=;
        b=hqJwukLUIuZdcw7FYiJcoKL87WTdOPpvgax81ueURsL4eMu9G0NWilm7Q2dUHoUrqW
         1gRErJOf88nNezQGLdCnjDIQjtqOYI3MMK0ozMnRcXwmbXkWfy6TJ89SjXPrASs8dXE5
         ez2FhjRY/70qrqIHwL2tBF/jbxLMMXvI31dcziFp7siyrBEUUqHlcqF2RjyykOWBrN47
         gZxPr+PcM5IzOqa6b86QE9zFMb5bt27Xt9sMTZ4Xp3adEblXWiwao3p1P1b4AM8e54px
         vK3xS7N0Zm6Mmjgzwjtp/ivRL1qbwLGb/kaxIv7HHqMQAhxl62+YQaI5QcG/dhr4E1W1
         n6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716322159; x=1716926959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWrpteYcdBNlx+6493QsXpUMihLRMiYDww87eKY9bg8=;
        b=gZygGFFoA3rGQOrjWSKbEcil7dgoxI48wwAkP5RrD2CeNGyLFDFmmSRMM3SZaTTgbx
         YK7wbOZQX3Z1PT1wXmJ8IUrNXyHFCzQsdfe91IVLH5Y3N84ZE06kn2q9cwzAzgsfwTsz
         SBGy71MNzIsGeZCkDrQMz8e3JHhTJMupCa0H0SbgMEmHKIZRKxBLClRzqnEE1aPGWDdl
         EuDNc+P/FQUkZtqNGDG5GHViMJCYK4h3U1g/wf/8Sd5jmMNhOBm65Opv024ZCVJWiESA
         ti8p4iZUAsBuYn3ivrC6Vj9HoWdX0pQy9L4jdPadJ7qSTGy0VCX8pxrtmNJ+Ixdn42KT
         Z+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB/mmiL/xavdFdc4HSlrzezlNhuYd6+jkUGh7QiIUxkV5N1R++1vkxfTWKj8pkxeBF6o70Aspi+2mz4Hfld24Yu6C9YXo=
X-Gm-Message-State: AOJu0YwkGZUboUX5ZPICaPcyiIb82hU/RfUQHTek8aD6tLW66yGftpxe
	plZ8KjZqAa4Y1l6zKhUUfZ3bz3X7t9DK6pwQsx6Ikf+HHNT1KdJDQYGFb2ONuNM=
X-Google-Smtp-Source: AGHT+IFmqPzAUfkTViTVSpsDLLwhzPZ48S3LYwKXKDRY2ly4piMizKtsvAivJxLfypb9ZtbG417izA==
X-Received: by 2002:a05:6e02:13af:b0:369:f53b:6c2 with SMTP id e9e14a558f8ab-371f9405868mr782595ab.1.1716322159199;
        Tue, 21 May 2024 13:09:19 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893703b15bsm7042659173.54.2024.05.21.13.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:09:18 -0700 (PDT)
Message-ID: <6c7676ae-f0a3-4a9d-bcfa-f6fa0a03c928@kernel.dk>
Date: Tue, 21 May 2024 14:09:16 -0600
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: David Howells <dhowells@redhat.com>
Cc: Steve French <stfrench@microsoft.com>, Jeff Layton <jlayton@kernel.org>,
 Enzo Matsumiya <ematsumiya@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <110d2995-f473-4781-9412-30f7f96858dd@kernel.dk>
 <2e73c659-06a3-426c-99c0-eff896eb2323@kernel.dk>
 <316306.1716306586@warthog.procyon.org.uk>
 <316428.1716306899@warthog.procyon.org.uk>
 <322229.1716321947@warthog.procyon.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <322229.1716321947@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 2:05 PM, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 5/21/24 9:54 AM, David Howells wrote:
>>> Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>> However, I'll note that BDP_ASYNC is horribly named, it should be
>>>> BDP_NOWAIT instead. But that's a separate thing, fix looks correct
>>>> as-is.
>>>
>>> I thought IOCB_NOWAIT was related to RWF_NOWAIT, but apparently not from the
>>> code.
>>
>> It is, something submitted with RWF_NOWAIT should have IOCB_NOWAIT set.
>> But RWF_NOWAIT isn't the sole user of IOCB_NOWAIT, and no assumptions
>> should be made about whether something is sync or async based on whether
>> or not RWF_NOWAIT is set. Those aren't related other than _some_ proper
>> async IO will have IOCB_NOWAIT set, and others will not.
> 
> Are you sure?  RWF_NOWAIT seems to set IOCB_NOIO.

As it should, no-wait should imply not blocking on other IO. This is
completely orthogonal to whether or not it's async or sync IO.

I have a distinct feeling we're talking past each other :-)

-- 
Jens Axboe

