Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966072C21D8
	for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140877; cv=none; b=eLQg6IJJH/d9OGUZvL1mvM6Ccwu1MbyPBg74XLlVpTHB/TooNu109XyWKPFmgyCsx9/Jw3dmjKgFsS44SHQTrtIw+YWjoAUxJmesGDeoIxaDlKF4JyL1AY9YyltFPzmbVoyDCX8EnEAz69jREdLwpx9qWgGk09mQiT3LAYO7esQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140877; c=relaxed/simple;
	bh=7ftGvN/R/Ps0GPIX85RpurbPLiXS1I3fprN0bjaLYGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fC0utrr9Mgrqe3yC1t3VauA4f8ncoSWiHfVXwMnmIQ1WpWJ4WelZ5eqqAyAksKr3+wbC8uBA0wh3TDVRK02kO7cvuid0ZdGrtH54efJIcU7QSsLlzAwb0r1u3v/RFlvotr3DBsOHnfmMfe1UctLO/BQ1iiJktiftfsmgEAcKkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=S1j3KKTF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="S1j3KKTF"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso255225a12.1
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758140874; x=1758745674; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4mlHJ7N2GtjpEnD9iNY8gv7p0x+AwcaIWO1wg2Altw=;
        b=S1j3KKTFJt4H2qLkEmMMSb9poqBL6tUdJQZoNFX3HeJqZa2aT9nWQFI6oF91kDZypw
         A6NVzPailFKQ0fCo1mONzzia5DK+DfbTCivgCJwkA3FDeuViX6UKm5kGLpbVGwHW+Wcw
         yWsSH+JT2SIJa7fBlvW+y1/Gp5rZuHbTsLSQSAXUmL9MZKnjayJmVeyKOnmOUDGE4frx
         VrplX5NepJh6Dbkkicqj6Bp9Sp0svWPk3rbVJdKhsfvyGx85xph1eOTdUS7nBqakI6mt
         udVDS2LS8M1A9/VzUnUq6L803OxyEtxTN8Nr/Z3lf7ah2x9/wHqsRAJcwUaWvItt/j3q
         deNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140874; x=1758745674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4mlHJ7N2GtjpEnD9iNY8gv7p0x+AwcaIWO1wg2Altw=;
        b=Sxr5aKTMV2EkiSp0vkFMMNXgQOKeRmV8ln5p1CcHe22emVJPSM5C89abCnK7QW+rGF
         v7FvJZNZn7jq79w/SmTWca6j1JY7rz12o1EK4oiSRkbSMnKUn30VPI/Io8GGjR8uvOcj
         rWPmDr5HRA6/jWh9iCCg5dRUWl6BQ0tp7y1GLZ+Riu3C540BbMGuJ7ZHCkMPDZbXXnuN
         4GjiuU+76mpArC/rRxmj9VmPu0AvdNsZDFgIi81Zjw6fA/cQOmt8I+jKUMATTdg317vo
         IWstTNGcztgcCqNt/qL3q0S9Mgu47MZKV2gtu8mQibu/fXSlFgySnaacmW9k4L8VLite
         0ZOA==
X-Forwarded-Encrypted: i=1; AJvYcCW8kOdfHZlkHIzt2GeQUTcMPhd8whQlf17uFY2tVI04NEdh2IrgPX1YdoxyuJ8QtFK2cEyZgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuX1QAOV91eX5yvY7uruyW99XvZNexA2dJslGXf49aGugmiEUU
	SHJ233391EBG+HWAvk5GjSEze+flN/BxrubbvHV2j4Uj8DptuF9z+tE4Ark89bM+o8gkrKuEB+y
	0ZDcjqyphWW2vF8trdMsv9y+uFdUofcvH7nPgcu7UWg==
X-Gm-Gg: ASbGncubsCs/EonkONaLH+Gh/LRPwwlpCZNCw8PKv6M/lhF7XWMISMiJa++Z53WETVh
	/f74Mv2nI1J2/spoDel9spjQntVsUZxrQYfDUzQbJc3GL1tCWXHfxO9PHLP+54pfUr/CHvHRUui
	s30Q5ADlltRU9hB87e3FXdnxZ1VdgB1bHFivNTH5UHkYzuWSfXOBi53yLzPQMhnUruq0fWKbZ77
	1AW44QY1iXygVNYIYmOeaZA4WFFJ1tsr8vk1PViElD7FJ0EA+ka5SE=
X-Google-Smtp-Source: AGHT+IHTHtpXLrzOlNF8ItBS1Dao3rHs8rUuADCH4WTPP8QnLumlzZRuwQZByHIaY7Yr6edfpyVLQ1M4x0U8xNNPnIY=
X-Received: by 2002:a17:907:7b8c:b0:b04:6338:c95a with SMTP id
 a640c23a62f3a-b1bbc5490a6mr373843166b.45.1758140873916; Wed, 17 Sep 2025
 13:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
 <20250917202033.GY39973@ZenIV> <CAKPOu+8eEQ6VjTHamxZRgdUM8E7z_yd3buK2jvCiG1m3k-x_0A@mail.gmail.com>
In-Reply-To: <CAKPOu+8eEQ6VjTHamxZRgdUM8E7z_yd3buK2jvCiG1m3k-x_0A@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 22:27:42 +0200
X-Gm-Features: AS18NWD_SzRUSSGY7GiasnnPbKogXv5-_s8RWyt66I7bKnW_Disajb-Bt-pl0Fc
Message-ID: <CAKPOu+8vf5DbR=cJ5dArut=QamTu-EdpJVta_Dsk+dQDpY68UQ@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:25=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Wed, Sep 17, 2025 at 10:20=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> >
> > On Wed, Sep 17, 2025 at 03:59:07PM +0200, Max Kellermann wrote:
> >
> > > After advice from Mateusz Guzik, I decided to do the latter.  The
> > > implementation is simple because it piggybacks on the existing
> > > work_struct for ceph_queue_inode_work() - ceph_inode_work() calls
> > > iput() at the end which means we can donate the last reference to it.
> > >
> > > This patch adds ceph_iput_async() and converts lots of iput() calls t=
o
> > > it - at least those that may come through writeback and the messenger=
.
> >
> > What would force those delayed calls through at fs shutdown time?
>
> I was wondering the same a few days ago, but found no code to enforce
> wait for work completion during shutdown

What about flush_fs_workqueues() in fs/ceph/super.c? Is this what
you're looking for, Al?
