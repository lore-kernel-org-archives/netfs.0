Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481EF13BC26;
	Sun, 29 Sep 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727602672; cv=none; b=LPOuy5ikhioKVmFFoRWX2IYTky5ASSE9GfN0yDGbkrcV1oZIGFvf8PJs8+3MPgbq4Z0+nQmSw+WTQYObPp1mVRITSsGW2NU/9X9eJT8xbESG13+qRtFWfSICCkQgXy6VbtLWSh3sgaNYRhu9Sau5xOWriEeNxnQtNhTfer4H0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727602672; c=relaxed/simple;
	bh=JhnlrgiwaYgmf+C4P4rH3Grzmw0UD30oyedNJem4K74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cItpCZg5EOJ57iJXgpjLs3yjfsNU3IK6P+b/DXWQYXK+KAEcgphVCzvyF0Gbh102ekbQtl4AR4wkdrso/VMIyhLBxDUe9Z+LuT/vpFBiTKqPSg1/iQrYP17KudXkNdA4HPthf569YR1ItqYQ4DH2/m7euVeaIK+Ydyl7p20rRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnuwPEt4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnuwPEt4"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso2954582a12.1;
        Sun, 29 Sep 2024 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727602670; x=1728207470; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UI3JnvNxoordn6WEYDEb5d80WQsWt5pSs8xiHh3j060=;
        b=EnuwPEt4h8xXq4ZgLbOJPat2RC5mvf/gz3aliYFqSjyWL8iCcp9+1vnyMuMC5tZ/6F
         +AKsXzdd/BJYChs8eqz004IYg/x4lTpof3DeqINj6VKk4qdGa9EfZwjl5wP20idhmv8k
         MuUBn8XhErDedjbzjUg9tjGqckHNNtsA/w/QfaO1X6a0ewLM3s273YQyhAbxMDIL/X4B
         4zTOgCwUv7HeUiMPNUO2WWL/N5Vp2gvEyFPF994ue7gCL5e02tfAZQBbfob8lmBsyVG4
         Ge5LABb6DEK2aBxgz1A4lKXaXE2aJHELhhBg/CTp0F57IL7TKKFEAWlsHwUHKXop6/RC
         4JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727602670; x=1728207470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UI3JnvNxoordn6WEYDEb5d80WQsWt5pSs8xiHh3j060=;
        b=wnfgELqXTVq7CH9BlEg9ndQKy4RTrEo/hhxZQ4jVkLSzIFaoTQvP2+wlhXIhGDrdAF
         ThYj9468ja5PU9QMhWXcHNCVg2y9q069pJx6izMxvfVNqsMP1HV9v+wSfKGm48W50TKJ
         /9rYGfWtoESefFWWaU4w9+VpLS6LRswKvC8/rIkDc+8bHi52Se1RzL3iWVCrqGhGJlbJ
         iyaRUZKMj9jsU95XAjAdBS3KDJHFOXOfzw+ODnl+8ioxGYnUw5iZr3DXn0POxRiIsxb4
         Ljj7dYbnVKX7p1kac3Ti0x0Wi7Wd+2aKp1FN8jWMQmW7UMemzM/qtHV4tK/qK0GwHnEV
         m18w==
X-Forwarded-Encrypted: i=1; AJvYcCWAdmaeoYkPnNXQbi755Ye89QWDN0dOEMg2XQCzL8MN5v/yXtnjAYDLK9WEeeO/0Hn32QkNfw==@lists.linux.dev, AJvYcCXFZl4YyvmuCiQlYt7yxx/JKVoIoky56W7SgIleOsD6IOnhOx/do0poE7/JNm7xoy4y93FCcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUi53KXOmp4ZmyuEDCGJYs3A58CZPnZezxIJSixYdwKc9xgLJ4
	jqW2oAzGk6woTgZABZdsp1pC36DWBiWFaja11YYOAOyn6Q+UvFXz
X-Google-Smtp-Source: AGHT+IGlIri+CO3nO7SHxYS35QDjVZ1ed/TCsk0eNd1dMV/4gMLjT42I+WIsw+2rLAY8Xe2G636KQA==
X-Received: by 2002:a05:6a20:cf8b:b0:1d2:e81c:adc0 with SMTP id adf61e73a8af0-1d4fa7b53bemr13375412637.46.1727602670436;
        Sun, 29 Sep 2024 02:37:50 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bebedsm4292766b3a.85.2024.09.29.02.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 02:37:49 -0700 (PDT)
Message-ID: <c688c115af578e6b6ae18d0eabe4aded9db2aad9.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Leon Romanovsky <leon@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Manu Bretelle
 <chantr4@gmail.com>,  asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
 christian@brauner.io,  ericvh@kernel.org, hsiangkao@linux.alibaba.com,
 idryomov@gmail.com,  jlayton@kernel.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Sun, 29 Sep 2024 02:37:44 -0700
In-Reply-To: <2808175.1727601153@warthog.procyon.org.uk>
References: <20240925103118.GE967758@unreal>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <1279816.1727220013@warthog.procyon.org.uk>
	 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
	 <2808175.1727601153@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Sun, 2024-09-29 at 10:12 +0100, David Howells wrote:
> Can you try the attached?  I've also put it on my branch here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-fixes

Used your branch:
fc22830c5a07 ("9p: Don't revert the I/O iterator after reading")

dmesg is here:
https://gist.github.com/eddyz87/4cd50c2cf01323641999dc386e2d41eb

Still see null-ptr-deref.

[...]

