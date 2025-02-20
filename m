Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAC15574E
	for <netfs@lists.linux.dev>; Thu, 20 Feb 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063665; cv=none; b=HJwW6turF16dT5wo9CnSeqoIuur+UHp0qg4DWi5+/rKIy4KwDD+W4u7/2TtQ4OiIiar40Bia/4KoRpX2PJBLQBTtw426lGIvpe9hhCSBJHxFRy77pNR0Tn856QWxlZAJe0k+EsNZXArlbB0hkuhFSKNjb77kHLk/wf9mImVo6Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063665; c=relaxed/simple;
	bh=QX45Sw49DqWmVMlR4tXEGRM0noTXirnZFmIFacKpQVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NupOp1inYTDUmOwkWyK8pVuVQxuwUtsJ5CPogAjbKyyIxZ/ZJ/owQtlzGP3FIcP0Fyt4tBWrvlziwV0f1zfzYEqFEsM7WoF9N2uiR/d+ISZRmjHXPZeeyiOakkuOwrdLiLyMph9lrUv8bL4NCjMRG/F9YayntD/qFh6p1QnJKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=J0BpPz6t; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="J0BpPz6t"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso1628322a12.3
        for <netfs@lists.linux.dev>; Thu, 20 Feb 2025 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740063661; x=1740668461; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX45Sw49DqWmVMlR4tXEGRM0noTXirnZFmIFacKpQVc=;
        b=J0BpPz6t3bY1zTyt5H4h20in2wuNbv4XDXR7U32Oe1VIL/bR9kyCFp1ZWF/ZZrp7sO
         0zEJjehNJ0vOCciOgIGf5YLY9zvHf1fZg1VrZb19rt1V2E8xFnWPEWxiDN1KbLk1y1rY
         jGlMyOug3Wns0lw7tTC1qFk7rsqR34q8vnvoib3ISZsgVsJd3vLLbnPgjOHmsaMzJSqj
         SaDQuVuKaBI+YCY8zoBU1t+a5ndrEp7au/tuqEjk7IHZh2C6nlBJyx0j6zGeKjRNBTQl
         eyaXQlBGv6Lv9IsIl75n+ZXQEnxLkNw9vCtYPzjHR8f3Xt/22GcuO1LWqPeSFLthBwmc
         yeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063661; x=1740668461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX45Sw49DqWmVMlR4tXEGRM0noTXirnZFmIFacKpQVc=;
        b=chQ3B8C84DdQFnuc+J78zoeYL0MJ48BmbT+n2ldL9s6Ex1Hxcj4jUa7+2absx4okbr
         XidpsZvQglBHTfvOzF2b7C+/ulc1UIp2iB2dboly93SHGZjhJFDsU7FvdoSykTALY8HB
         oh18P2vun5/Q0fj2dc/U+r/54nPbHmkW5kW7MoWNSaVV9NRX6vGDI28b5CTyiXA+9uTN
         co6n2S9uKNHtbRjVerNzqx4TBS6SVzcFEsMHba474VWY3FEJXgs2xj+34fGDij9/dvqQ
         eCBgVtzqA9/MJu+r87/th07ltaPJzNqC1W71HTbCzxnX9R7VYxIFMhHdRfOsBtL9qm0f
         DW3w==
X-Forwarded-Encrypted: i=1; AJvYcCWl+As+Qdm/rKARuvFn0TPPanS5UXuUd1zm/qfTHbvdWAJds/xLNyqK9AlXDwn3fTZ1MYXhuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw17PYWqRgK7ISnduH5ZVk1XgMVBGbbE7YhHI0B9tKo5Tl/T3tl
	LUkqaJeuwlBB2TMaicqQGsEeGYy07NiDokZZMWJ3nkzqLCYvC2h53oF55EuTUPJqfvI8pql2Ut5
	q8TcEIwAwj64R85UYYjKmC+L58DzINuHJrfvnyA==
X-Gm-Gg: ASbGncsn8uR7vHWrRNRQx3bpQI03Ufu8BLPCtTBOOq/YdU3fcyGnOiwQeRS3gTnL1RO
	ZdZCYrhVQRbOR1idXIRNiKSh9hONxJvOUkl2h5pKFttk00Ofk/OrpN6Z2uJY97Ea/K0wo90IN35
	zKhOELJ+ZuE32Ef3oJDvSLwO0f6w==
X-Google-Smtp-Source: AGHT+IFsNIPyDQGc+75Qve6xdXZqYra68xghYqvPNR/a93wAgL+cet1YYKlnIsmF7J644V3bLmLkzN1ceWcyLicDD5A=
X-Received: by 2002:a17:907:3d8b:b0:abb:b1a4:b0fd with SMTP id
 a640c23a62f3a-abbccccfde8mr753397866b.7.1740063661328; Thu, 20 Feb 2025
 07:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com> <3978045.1739537266@warthog.procyon.org.uk>
 <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com> <2025022051-rockband-hydroxide-7471@gregkh>
In-Reply-To: <2025022051-rockband-hydroxide-7471@gregkh>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 20 Feb 2025 16:00:49 +0100
X-Gm-Features: AWEUYZn11RtW2auyLztupwrGFbfU0x95LBmhMBqsyNDNUcIi41ux5lVFUDQ1JfI
Message-ID: <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:17=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> It wasn't sent to me or to the stable list, so how could have I seen it?

Oh, of course, I forgot to add stable. How shall we proceed? Do you
want me to resend to you with David's Signed-off-by?
